Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61108CF9C62
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 20:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srkCu-0008LF-M4; Fri, 20 Sep 2024 16:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1srkCs-0008JL-Mb
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 16:26:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1srkCn-0003tV-Sq
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 16:26:20 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KItd5E018588;
 Fri, 20 Sep 2024 20:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=HL+IINJ+5eHkxAMFHBM/sVcoj8hP4mUAcd5g59assGg=; b=
 SJGQRV/QtEFcNqCjmhjQjX8jdxzAj4/Eggui3GEKLGij6voCspUmg0t7C1kYXRgN
 8LW/+gA/7mR8VkPeB9E+lPHFDPAiF33QpikBh8qwEAKpZameC1Swa5zmUaFFDaEq
 nu2KnFxB/i86vbXw81Gkk+ikjxopllnAbhE76juTsdYpXNOmQNALASoQYVfWtNbb
 xCNsHT1ubNYunGGMfN1JVGT4VjoTXANILon9GUzD+aUEtB5z/HEgLRQhsjNkyfH9
 PQwQbFR99ws3iBNxskptG42OCQOKUNnJF+lUL6xAx63yVZKn6W4g2QXAClWI7kov
 /UXyTnnZiLRNJJvUJ9PY4g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sfyppt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Sep 2024 20:26:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48KIJYZx015059; Fri, 20 Sep 2024 20:26:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41nyg7vxyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Sep 2024 20:26:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8OIn8ZEcerq1hMqa/zyra2YJmjzsL75VaeEWVWTlLlvXkjDyfXMUgNJ5Zek5uvQi2rEIvAN4K/UYpI2/mzuAPJptwlF50xWlnUUaQTYasVNRj8D0ouBfFMQrQp4eysJxFIaBEG1RZ1zQPA6jy5ggqlOY1uvSWHt05hYrjmtxvHdh9UATBbKj7SEqXKZeNlt8LoOyCbnx11wiur5dW2Hg07f3l7k85/JVFlj+c0UoVrsEqkRLm6zeir7Bfa9GzH2UIkvts7Bw3EWOsnVUBf5A5NwUmBg/JOBeS42rlEyEMznh/yWuMSvN7Bp1TcAfpMoH6fRsoikIu6I5qNQibpG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL+IINJ+5eHkxAMFHBM/sVcoj8hP4mUAcd5g59assGg=;
 b=YbJTeSwnb2gxNRxjrbp+O4SQs/LWuugSkLHAgQcb6GvLGBtrLHHYjYpqKVjUJMuEuloRKp9U+SeRok9QjRTjATMAYqWKhkxhzJIo9VXEp6yJ8b/QyOCmfVMSWA3znyxeZKXHJFWjw/E+ixi4TT1h04Lj8zN9UAfveX853rAHonClJA1ta8tfSmZ2acYBhYC4Naz2MTPyowMTIwZSbe0ffPNFinm0BY6o0SxipAN0lLMyDf9sMG0XHcRyGNP+Tkq6jY5TWMqLvH1TG1W/icNzKE3FZLLLbLtpEbH8wA4OjmURjH54/x31AiUyYoKp89CJ61t+EifxMM/o2UayigDJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HL+IINJ+5eHkxAMFHBM/sVcoj8hP4mUAcd5g59assGg=;
 b=bUyxyDAcrrcom/7GsOJUeUzt7/IS3ORgnZ6oULvjWQIzUsgR6EcbYQcnhx4M91pyVTEFQTqsQlOOQATqzCh3m6TpO2mCLwqYRGO34JcFImIXtYmyOR+JHZ1bwr4ljc4WEhN0ecHKGQZ543o0EJZfQz/SbaSLEnBEiWeeoM/VZzQ=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.16; Fri, 20 Sep 2024 20:26:03 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%4]) with mapi id 15.20.8005.008; Fri, 20 Sep 2024
 20:26:03 +0000
Message-ID: <d70a7757-4c39-4801-857c-607420cad4b5@oracle.com>
Date: Fri, 20 Sep 2024 16:26:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] amd_iommu: Add support for pass though mode
To: Santosh Shukla <santosh.shukla@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, joao.m.martins@oracle.com,
 Suravee.Suthikulpanit@amd.com, vasant.hegde@amd.com,
 mtosatti@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20240916143116.169693-1-santosh.shukla@amd.com>
 <20240916143116.169693-3-santosh.shukla@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20240916143116.169693-3-santosh.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:208:23b::25) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c9e8d6-b430-442e-18c7-08dcd9b272d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXp6UWZnUE1KTG1qZnF6MHVMcVV6b3BKdnJQcmNleWR1eWhQcE4zbHc5SHA5?=
 =?utf-8?B?dktzMjZkK0tDNnV2Zmhxa0pqb3VIT0ZJQngzY1YxbXF0TDJCZDMzTHlwck5G?=
 =?utf-8?B?dTg4eWNMNEdZdXB6cmFqa2RCeWlmbVdQdXBVaCtpRXo0U2MvSzRPdmZZUjNJ?=
 =?utf-8?B?cURuSTlsS29WUHRsWlY2ZDdaZytlTFdUL2xoSUNyVUtkaHI1RnFnaHZwZWdJ?=
 =?utf-8?B?WVFpK2dndnZGbTNyVUI1aTZXR1pRNldQSVRESXZiOHJ4S2NCSlVQaUcxblBL?=
 =?utf-8?B?bjNEM1hiSDBpTVpWUXpBUGtFQlNXZGlOU0x0eS9kTGREeVhVMnpMZEpZVytS?=
 =?utf-8?B?SHp1eU9nUDZRVS9aNVk4MjQ4RHVPSEhlYlRnMStrdTRzSDVpbHptczNCSWdP?=
 =?utf-8?B?ZGdvWHR4MnNEZVdMb2VKejUwaXRRT3ZybllZNVZxZ09FYVN2ZWluckdJdkN3?=
 =?utf-8?B?b0FwTnd1cXVxa09tMGtJT1BLNzV4cHdlZ2lXR09XT3FnZ0UyMmZtVitEVlRP?=
 =?utf-8?B?VEZIN0lDUDEzdU1OU0pwOWp4TDlsWFQrZ090aC9ZcXA4cXliOVo4SjUwTDlJ?=
 =?utf-8?B?cVJKS2ViWXlzTDZ3Q3VtbzFub0l6Q1JBYWVzL1ZXMlJYemxiQTFJUUxDSnlk?=
 =?utf-8?B?UWZQRVpnL0JiM0kraGJ0bDFKQThOanhRa2IvR0JyZlB5Vzc3NUY3cXowTDFj?=
 =?utf-8?B?c1o0QVRPbFBja2dhYjlMeDRwT3BjMU4rcDlCSFFnOVQ4OTBlOVppUEl2V2Fo?=
 =?utf-8?B?eHVuREU1bGRTUEFXa2JiMWdiaXJyOHpNV2wvQlRlZGxROUJ6cWQrZG9MVUFk?=
 =?utf-8?B?L0NsaXlUNXhBcTcvL1NjaGJYQTNzbTVGZXVpejV2bUFhWWJaT2VSd2NJYUVH?=
 =?utf-8?B?T2wyNEg4YldOb0Z4aVNMYTBkaWtwZWZRbUQ5UFBHdnFGWm9tbHQ2UGpIKy9E?=
 =?utf-8?B?R1M4VWdyWG13VXpJOGNmY1pyQjZGbGdFYS9hbnV1anA1bk1maTlQeW5vMjhQ?=
 =?utf-8?B?cVdCR1ZqT1ZhQkYrNTVDTHlkcUpnY1cxc2tiL0lrSDN6dnZZOWw2ZEFHc3RG?=
 =?utf-8?B?d0VBSzFTVi9BWXgxa09IT1BKLy9oTWQrd2w4cjVuckJqVVZSbS9YM2FaRVlz?=
 =?utf-8?B?VENJVWlVN0RmSTZJM3ZjMjJHYTdvQ2RrL2ZLRUp2Y0hQUEczQnI2WGl4L1U1?=
 =?utf-8?B?WnltTjltdGxlWVJaaEUyMGpDby8rNTU1dXVBVXVyaVE2b1ViUkYrQ3Q2K2hn?=
 =?utf-8?B?aGpiTXFXOElWUFB2UU9jWDBBc2xBT3lZY0Ywb1V2ajlvbHA1Z3pEOENCaEZ6?=
 =?utf-8?B?Y3RNdmwzTjJCcGJ4anVtcndEenRPWkRIazFsdWZZclpMMml1dDhWY0lsTmNL?=
 =?utf-8?B?NWFodkJhc1NITDlXN2lNODVoczdtOGFUbk1GSDRCaG9sR3lNblVEUTRPdlVt?=
 =?utf-8?B?bmlDMTdoaFpqMSt2d0owcFRBb0UvbXFodWxEdUVSMy9BRmZETEV4QTVBQUxD?=
 =?utf-8?B?NEVIUnlDcFdhYjB0dm1vdmlUOWphMGlMSFRDT0IrNmhYNzVnV2N6QzlIcU5x?=
 =?utf-8?B?S3hKekIxalUydlBINHhBMWE2V1F3dDFqd3luZXB0amdvc1NxVjZkd0RGUTFO?=
 =?utf-8?B?QWppNGI1L3BoMjkyWkNtL2h4dEdnMjVmRjhnd1lXTlhRWTgwdU1iUHZzaHIy?=
 =?utf-8?B?S1JqVWJQTXdYaHBLT000cnp4QUlIUHNOYWRRSG9IRHdxOWRxZCtnczJCMkJ0?=
 =?utf-8?B?OC9RUlJqczZuaDhXelc4ZTRoTXdKZ1RpeUpzdGg0aTB2aWRnRm1yQ29pdHdj?=
 =?utf-8?B?Mk9abFlGb2s2RFd3bXVKUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWRKYkx3UjV3LzEyK3ROSUtoblRqWnRqbC8vbDk3VW9nTkMwQjk1SmtFbDE3?=
 =?utf-8?B?cjM4WEY3Nmp6ZEs2ZStiSkFGRm0xdGc4VTNLdncvdUorSWJvVWYwSCtTREJm?=
 =?utf-8?B?RCtINjdNSzBPYUdxN0V4QmVQT1cwZVdtejJ4Q2lVbjhSV2VaL1h5b0pJaFhh?=
 =?utf-8?B?UHdoeGVsc2RSRjBJOHhCVnBlSTlpbGVNUDBaekovd1JkcjlhZGxsa2ViSTh3?=
 =?utf-8?B?ZlhzNTRPSTJZaXpiUXJab2ZBK1VuR0ZmYURQbGlFV3dzQWdGdFIrMy9LdklU?=
 =?utf-8?B?d1BRa290a2dBV1FUY3A4R0hEYmVWcTYzZjNzTmt1WDlhc29JeGdoaGdLSzRM?=
 =?utf-8?B?dFJ5eEV2TEFTL1lYZnVXNU44d3hROWNvTHhmRkhpZ3dhQkxXTVhrWWZOSG8x?=
 =?utf-8?B?ZlVnd1VIUEx1VVFFVm5ha1VyeVFCWUhkMGF3NXc4S0ZnbzZrak5Gb1l6ZkUx?=
 =?utf-8?B?WGF4NERNWmxnZE9uL01RNzdOR0ZHRElhaW1KN3EvVmJoRWJJV0JwRGc2Wll4?=
 =?utf-8?B?bU1hbzhEcUtobmdlSXA1N1h6ZWlEZ1ZwYzE0YjlYbERRN0Jza3BmalV2bXpv?=
 =?utf-8?B?VnI2VzlHN0VZb012MEl3TzBtZHh6emtFbHB4aVlkR2tEUnNEcTVpN3czcVA1?=
 =?utf-8?B?VDVjaXlvQ1JWU2ZJUFo1Q2JpWUZMOFd5bjBrVXNpcWtNNnFpWFVEU25pUU56?=
 =?utf-8?B?SlN6bnIxUGpmdCswVnp4aUxGeHAwUlphWE4vejZWc0w4KzJKbWVFL2Z1NGRu?=
 =?utf-8?B?SVhkajVRaktGem5vYzFBOXZXcm1QNjhkakV6M01la2l6ZllQa1ZWNVBSNEJH?=
 =?utf-8?B?cUVzNmE1YVVBTWpLU0w5Z2R0MkQ4ZWxKZ3FRd2JPb1lPbmxUcmVRdnZseDNa?=
 =?utf-8?B?Nmc1L3NSVWFNcEY3TTZjS0dhYzJFVXhqTnJOcG92dUpNQ0FHVDdrNFd4Z1BK?=
 =?utf-8?B?dDFwT2NPcUxvUDlEL2FMNllybHJkc2tseGFOcHpqM2FCVnB3WktWOEVKT2RH?=
 =?utf-8?B?U2svRC9lbWZxMFp2cVNTSXZuZEhRZU81V1U2Z0lLcG1UWGVtUVN6RWM5YzZL?=
 =?utf-8?B?WXNTVndwOTh6K2xmMm5YYmRLdTNqeXByeGlMcXF3cDFqRmYxUythNllib21q?=
 =?utf-8?B?ZWFPN3ZVb3EyV1l2U0ppUFVUOHZ1Y2t0UUdFZ0JJaTFBUlp4WFVmY0VUbVhH?=
 =?utf-8?B?dE85eGdqNnZ5OGxjQlpQQVM4NU8wOElMSW5MSXM0NWkyaDFRVFV5WXc0UnNu?=
 =?utf-8?B?cGlLVXlJZXdwNTZTUXRiUEJOTms2QTZER3dFRFBvaldsbmF0enBoY0pKaWVM?=
 =?utf-8?B?WE9EWlVFeFBrY2ZLRVRIMm8rMFdESzZsOHZDOEcyc1pJMWszODMrMFFreWU2?=
 =?utf-8?B?QUZVUkowTHRRT1U5Z243TjFqc0JkS2lIMUZLeXpuU25veGEyeVZBZzNtQVNU?=
 =?utf-8?B?YkhTTUFEbkJZVGxOTkM3S01CNUtxQnFDRG5rOTBiWG01dk9QUVIrOXdRYWUw?=
 =?utf-8?B?R29Ha29OWFRMNmFtaHZRSzVBcXhjd0RtM0tWV2ZZR2k2dUkxSGdvV0N1eC9L?=
 =?utf-8?B?UnNrVzIvSFVuUjdHSXNhZUZlb2lWZm52TDR1cnFqSDJ1aHZPZCt0MExCdE1z?=
 =?utf-8?B?bUE4VTJPUXdCM3NNKytPd3ZtdFVoUmt4bFBFb2JLSmhyM2J6VCtzVHluT3FX?=
 =?utf-8?B?eHVXV01QQUVyOG1uU2JzZnU0ZGptVm5EZzZBL0c0Y1RvdFJEQmYzNVZ4Wlg2?=
 =?utf-8?B?ckVHK2RseU9LeEhNTHNwTUJJRmpJQzA2YjFRMGJNM21JZzMrRG1ZeUdXb000?=
 =?utf-8?B?MkNrZ2hxdVEzS0Qvc0NxUk5xbzdGeGpCZ1JiSW14TUY5dDhVRWpiMEhIbjRt?=
 =?utf-8?B?b3Q1WnFrVk9EWWVldWREUHZzTGJzQnlwTTBrUTVlcytXSUV4b2FYa0Y1aVBD?=
 =?utf-8?B?b3lVRkwySExIWm5naE9TbU1VcHZmdnI5d0xWK1RiQzg1OHA2ZVVmQXJlZjlm?=
 =?utf-8?B?R2tOZ3FVUHZCWE5EWHhwTUdqbTAzNDErMFF6RlBxUXJ6dzJnanFMRUZHdXFC?=
 =?utf-8?B?TWdtUmN2dDdrMjl1U01DQTFxVXQvTVJUL21pdEh6WDJSaHY4RlNGTGxjd00v?=
 =?utf-8?B?bzZqbDVvOHh0Um1nQ2FUWFI0aS9xZlhGVzA3Y3dhZU5UUzZ0a2Juc1pQSTg1?=
 =?utf-8?Q?zvPE9kDlOlVHnS4UrICzxww=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KKVYfiNh28r/dlZCAT/zse3kdRQBGy1kEgRG8IQzFbJsbZ3HB76GgIjoMKfPd9W11cRuCBOzUyvabc8wz0DhTTbxOTm43I6zbQ34eAW7H80ZAfP19ibvGPZVA4zi2BDTVqtzarEjOAuoUd36fSOpPHKXPMyJLwSsODmqUcrcBlRqgc+cgnwPRT1e89LZPm1cuLS+WmIC5PA5Z5BJQA8Yju1qcLisZUTQwvoCX65lGxGeLRrsnS4v5/Jz6Nod0C26a4yV6p57/TXcshR/gQzIFdRqxB8TV/pffG1OVfPG5N0QBOfbp4d2WffOaEDB9syfhaXAevbYpzO/3KLp+8/67O9xmluILJcPd64ZWyLA8rzSaotHo3FCRC9bC5EER2zh+2B6okuQdavJYjsQXA3QG8oZ7InMxdBNm3keNLKpaiuENhCNcYFY5ejdN61g1Yo7JmSW6R/T9QgMahRprtsA6a7n2Vfb60ETwp9A8NF2Qprx06aBJmy3zrfe1kIKlYmQXmMYhcC8PkPdDRnsbkcKW9Ei4o2Ps8jCSEyPMtrM1J4sMkWoxlnr09tzFoWsBOv5bgOunfAmagLI2iUN7jwTnZMepMZze4d7axqo7zr3J/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c9e8d6-b430-442e-18c7-08dcd9b272d4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 20:26:03.5058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQFXURpcIUogFClCWpR8KNVKgPsF9j4RD8HLuFdO1MzfyaXdsH3d41ELm8Go1AY4hpjmYa2ruzukjFLzpSa4+lHZG05nX1aY+WLlWOI5wNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_10,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409200147
X-Proofpoint-GUID: SbC_svfo3-aZKd6poILDbZDCgj3ERp77
X-Proofpoint-ORIG-GUID: SbC_svfo3-aZKd6poILDbZDCgj3ERp77
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Santosh,

On 9/16/24 10:31, Santosh Shukla wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Introduce 'nodma' shared memory region to support PT mode
> so that for each device, we only create an alias to shared memory
> region when DMA-remapping is disabled.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> ---
>   hw/i386/amd_iommu.c | 49 ++++++++++++++++++++++++++++++++++++---------
>   hw/i386/amd_iommu.h |  2 ++
>   2 files changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index abb64ea507be..c5f5103f4911 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -60,8 +60,9 @@ struct AMDVIAddressSpace {
>       uint8_t bus_num;            /* bus number                           */
>       uint8_t devfn;              /* device function                      */
>       AMDVIState *iommu_state;    /* AMDVI - one per machine              */
> -    MemoryRegion root;          /* AMDVI Root memory map region */
> +    MemoryRegion root;          /* AMDVI Root memory map region         */
>       IOMMUMemoryRegion iommu;    /* Device's address translation region  */
> +    MemoryRegion iommu_nodma;   /* Alias of shared nodma memory region  */
>       MemoryRegion iommu_ir;      /* Device's interrupt remapping region  */
>       AddressSpace as;            /* device's corresponding address space */
>   };
> @@ -1412,6 +1413,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>       AMDVIState *s = opaque;
>       AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
>       int bus_num = pci_bus_num(bus);
> +    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>   
>       iommu_as = s->address_spaces[bus_num];
>   
> @@ -1436,13 +1438,13 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>            * Memory region relationships looks like (Address range shows
>            * only lower 32 bits to make it short in length...):
>            *
> -         * |-----------------+-------------------+----------|
> -         * | Name            | Address range     | Priority |
> -         * |-----------------+-------------------+----------+
> -         * | amdvi_root      | 00000000-ffffffff |        0 |
> -         * |  amdvi_iommu    | 00000000-ffffffff |        1 |
> -         * |  amdvi_iommu_ir | fee00000-feefffff |       64 |
> -         * |-----------------+-------------------+----------|
> +         * |--------------------+-------------------+----------|
> +         * | Name               | Address range     | Priority |
> +         * |--------------------+-------------------+----------+
> +         * | amdvi-root         | 00000000-ffffffff |        0 |
> +         * | amdvi-iommu_nodma  | 00000000-ffffffff |        0 |
> +         * | amdvi-iommu_ir     | fee00000-feefffff |       64 |
> +         * |--------------------+-------------------+----------|

Minor nit: I would keep the original indentation here to help reinforce the concept that iommu_nodma and iommu_ir are meant to be sub-regions under the root container. It would also be great if the table could show that they are mutually exclusive based on whether passthrough is in use, but that is probably too much to include in this format.

Alejandro
> +
> +        if (!x86_iommu->pt_supported) {
> +            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
> +            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
> +                                      true);
> +        } else {
> +            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
> +                                      false);
> +            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
> +        }
>       }
>       return &iommu_as[devfn]->as;
>   }
> @@ -1602,6 +1622,17 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>                             "amdvi-mmio", AMDVI_MMIO_SIZE);
>       memory_region_add_subregion(get_system_memory(), AMDVI_BASE_ADDR,
>                                   &s->mr_mmio);
> +
> +    /* Create the share memory regions by all devices */
> +    memory_region_init(&s->mr_sys, OBJECT(s), "amdvi-sys", UINT64_MAX);
> +
> +    /* set up the DMA disabled memory region */
> +    memory_region_init_alias(&s->mr_nodma, OBJECT(s),
> +                             "amdvi-nodma", get_system_memory(), 0,
> +                             memory_region_size(get_system_memory()));
> +    memory_region_add_subregion_overlap(&s->mr_sys, 0,
> +                                        &s->mr_nodma, 0);
> +
>       pci_setup_iommu(bus, &amdvi_iommu_ops, s);
>       amdvi_init(s);
>   }
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index e5c2ae94f243..be417e51c4dc 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -354,6 +354,8 @@ struct AMDVIState {
>       uint32_t pprlog_tail;        /* ppr log tail */
>   
>       MemoryRegion mr_mmio;              /* MMIO region                  */
> +    MemoryRegion mr_sys;
> +    MemoryRegion mr_nodma;
>       uint8_t mmior[AMDVI_MMIO_SIZE];    /* read/write MMIO              */
>       uint8_t w1cmask[AMDVI_MMIO_SIZE];  /* read/write 1 clear mask      */
>       uint8_t romask[AMDVI_MMIO_SIZE];   /* MMIO read/only mask          */

