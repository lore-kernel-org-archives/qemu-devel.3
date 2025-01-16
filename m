Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24F4C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 20:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYWHl-0002ew-LC; Thu, 16 Jan 2025 15:16:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tYWHj-0002en-20
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 15:16:11 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tYWHe-0000oB-0l
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 15:16:10 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GJBm3V014518;
 Thu, 16 Jan 2025 20:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=ycnnx5tDlPY6U3LzLH9tjXCSUcSddeIcfr/MSKCLjUc=; b=
 RFaqmZWQEa/vNgdT3XPuZkvYt/po70rEPHgMOim/mkg/PgPeNXVxp9y2hXqNpCfG
 ABRl94KA34SlvhcIwqIBrbgR+HUd4aWm/+3TFXy0EfNksDmX9rHh7pD5FJFO2pAY
 KeltiwNIjCrBq8JR8RZuGt2gN+SJYTVGJ6QgBOg0ZlVqUedRIfH/v4820M18NhUm
 XuJ4MN8T8MvFC0iyMq0S/ljKNz7dr1yVhWl5f1Pz7IgNoPdaWqJgclIkgIT4jZth
 G3hWTS6GGIb7U+KqoixeGM8cEeXa4fZv0iSr1AWsYjunWxBOyJqIc/8p+zZUOPlN
 MPFOvI55Rk7QN1f7eoNrSw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4475mfgggk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 20:16:01 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50GKDxcM038717; Thu, 16 Jan 2025 20:16:01 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 443f3b9hcq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 20:16:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFdwKiln78njbQQfsjQZdCMhJvk3rAIK/eYaKfUvBDOoDLR/NIdCyHDSiIV4EHXfnIwovHzzMSCF8CCKSt2DUrJ45WOCuzg/AinL/NqPtXDBgo4Ma1tGJvrCL2hBvUn89jEB0W2uJY5YVPssq23+RPga9/ms1kgimT+BGrOkBiqo0C0nnzDANjRFSuMIqplwIT4suqpkobggp97aHZiclTClmHKfsI9u1yGEl0VkyQA5bQz20gZ7ai8+seGHrdMVOfUMQFqRTiKwJE1/7z78K5X7ZehqKBBQ3LTMJ6G31ypYKFqLigiyyWhvIQc1ZKyT8Ft4YRrgaNnEufN1BQm00A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycnnx5tDlPY6U3LzLH9tjXCSUcSddeIcfr/MSKCLjUc=;
 b=QRGaO/TDCMIh8aFdAT4BmiFdetihmprR1vgK7bK/9dpLtfLH/KeHYH9TFxwXDAulmz0ig2/xXrUZgyJ7HEe+X1EIcJfg61kkPmrVe3eZ8cdAJ1k2jSyTSOLVihGW6M6Pm/dlfF1BD+FCY0nEKmGA8FqYKtEjlqhC2k3ZjIbYGiHvk3YdhvZwk48j6nCueKjrr/HTe4rB9lCEuDNZLX27Yvfu6q1w5LHxX83MB2DKvWCeFSzxDZ87uVhB+rZztnK2YiL7//MjPrro6TVm/dsIXqlMsMa7bhiZENN0jSwgo863EQSV1dbt8SLDiZ4yYd2iw9hRpPADNLy5rpm0NmT9Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycnnx5tDlPY6U3LzLH9tjXCSUcSddeIcfr/MSKCLjUc=;
 b=S0ZIJlE16lCBreAqV04RR22AXJ056QJuQ6pof6A87zNqmABW46sV1/mUGJOerwdoxkGuVR4MndItlxFGjjCtm9eEYwExVlIVHZlvQd60uaDYAFa3J13Xu6UFOAOqwkIxjr/MzwbNFfwjb8gwcNRUNjTCQvX1hyMZn5txi3k1wZ4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 20:15:39 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 20:15:38 +0000
Message-ID: <9ccbd8e6-5e8f-444f-a057-5c9eca2020b7@oracle.com>
Date: Thu, 16 Jan 2025 15:15:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 23/24] migration-test: cpr-transfer
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
 <1736967650-129648-24-git-send-email-steven.sistare@oracle.com>
 <8734hifujq.fsf@suse.de> <fe25b4b6-fd39-4c2a-a104-343b59b405b6@oracle.com>
 <87zfjqedcm.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87zfjqedcm.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::31) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM6PR10MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: e056222d-e059-4929-7f1b-08dd366a8b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXhsdUVwM3N6ZWtjTXNIenh1V0JnRVlqSElIQzA2NEI0Mk5QV0hjZmc2NlVM?=
 =?utf-8?B?eUZLWGF1WC9VTkx1Qk5yL0dSRVQ2NFJnTTh1V2hmYUFqWXhkaEVsZjVxTDMr?=
 =?utf-8?B?YURDYlhWaG5UU29xOTRaSE4xREhTelU0eWxIYjBNaEROQWlpOFhiN3BxZFYy?=
 =?utf-8?B?TnJTSkpmbklWN09Ka3hjcWNBcXYxYk5JcitTMzBSWmp4aW5vQitnOVZOK3JB?=
 =?utf-8?B?SitpdVNNRmFUZmhIS3lXZ291RWtnTENhSEhJMmprREllbHlqQmRRQWNuUG1K?=
 =?utf-8?B?M3lJUGUydVRlOGtJZlB3WE10bFEyM2NVRSszK0Nwa3VvejJVcnFnQ2wxbTYx?=
 =?utf-8?B?ZjRrdGVrUS9aYXRVNmRMNGpnVS9wengvcENESDBTTlk4OGZsd3lrLzJEdDJ4?=
 =?utf-8?B?UTgwTEVialdBK3hLZ1dWWXljdXl6cW52ZVlmaEdHYzJaLyt1b0cycmJ4dVly?=
 =?utf-8?B?eGV1em9ZSlUyaGp2QkNPZkpDdkpSdnZNam9teU16eUxYWVhMViswNFpxOXEv?=
 =?utf-8?B?QTB4a3dJL2xaZGs4aHh2TVdJb3RucHdmcnZ6Z01iRWVKdXpkNlFLaHkxbjFl?=
 =?utf-8?B?SXNsU2E0ckFtSTdJL0ZjaFMxVEw3TDJvdFhjOFlBSHVLL3FsYURHSnJpdEZC?=
 =?utf-8?B?aExXUUJXSXlRaU9lbkljZGJpbXN1dTNUTitPYkNjaGIxVjVRNUN2ejFoeXpW?=
 =?utf-8?B?anpCc2ErREVFRVJiUW5lZG41VjIwOUIzT2NCMXFFTEZsZVZZOCsxdU1WbFJQ?=
 =?utf-8?B?aDMzbXE1OXRhU3lyVWJJMTNzZ1RZUENuc0VxYlF1Mzh3ZzZqeHdaTWVVTW16?=
 =?utf-8?B?QXVUMTZQejhxWHlvWEhUdk5ESkRmRGVDY09aSEtHWlhSbmNaMXlveHd6dGRa?=
 =?utf-8?B?RDlvRVJrWWtGT3ZPamdKcXFyU01vY2NzbnF5by9ZT3h6OWlWTk5pN3VIaUd3?=
 =?utf-8?B?bVNQTU1QdW1OeXE2VExSN1paTkJhNFByZmVkS0RRTjROclN0WVFJSTNhMjRw?=
 =?utf-8?B?c3FzRElUVjA1LzFIcVRSWnVCbTBYUFZ1U0FlaWVjOURhZkFOelpqb3FXSGZh?=
 =?utf-8?B?TlB3aDFRN01OOWp6TWxBbDc5bXZQZ1hKaGU2U1NNcGkwTmVRNDFuNHBjbVA2?=
 =?utf-8?B?dU1tTzZjT09vVVluWWl3cE1HUXFxOEkzRmhmcUhaR2l0c2JrN0R1L2JFWjJr?=
 =?utf-8?B?WXdXY000VXUyV2YxZHRIOGErdkc5NEY3NXdIZ0w3VjJaNy94TmZrcmVxOS85?=
 =?utf-8?B?L2MyR2J1NVc2Y1grWkl6d2FZeWlOTDFQeUNNRnB0QUxYWjhKckh2bVNUV2x6?=
 =?utf-8?B?aWJqNmdzUWJOUDlLbGtlSGV2MlBibnl0SUkrZSt1cEhyM3BCTmc1Q0VoVjJy?=
 =?utf-8?B?VEVwbEl0aGFiejJKa0gwbUpUZ0FLNVU4Y0lvWkZ6RnE0Q2lrcGZWQnpIVzI2?=
 =?utf-8?B?RnczbEtRZ1l5SlBFSXdvSk5lekpLNm5LWWhzU1NQbXZMbS9oeEVZb0pnUW5E?=
 =?utf-8?B?NE1KbE1IVy92L3pRL3d6Y3lscTJxejZzS1MyTk1ZcEE4LzlmcGJTczYzRmk2?=
 =?utf-8?B?Nnd1TW14Qy9JTUNSRzBiTGNKREFvTFo1YXRtSWlLTTI0T2hpdjk4S2MzVnFE?=
 =?utf-8?B?MnQ1VGdkNlVYL04wMGZFdDRvdlllWUpWM0FKaUtPT3krakJIbE9BS0JRM2Qv?=
 =?utf-8?B?ZkdSNldDZEkrbXFTeFQ0Y09WTURWT2plakpjNGg1anlQR01Va2h1ZUo5RWJT?=
 =?utf-8?B?UlhjN3VNUzhERzJXMkNsc2Q2Zno4Wkw1N0U4OTVqaVA0TmtHL3ZPM0hzVnVC?=
 =?utf-8?B?a01YcGg1LzlrS1VMS0wrRWFXV3FuRVZpRENkNFdUSmFIanUyWEt4S3hXam9j?=
 =?utf-8?Q?IurBG7rPZVX1O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmpQZWw0cGZqSUt2aTZ5THNZTTdCRTZTRDhob08zNHVvbDZyOUZDTGl4anJt?=
 =?utf-8?B?cGRKMW1RM0ZrUTNyT1oxNVpEUDQyNmk1ZSttbjJpVnVVTzg0UGhrTENOMjFC?=
 =?utf-8?B?c2JBV1M3T2hPUGtoZWphZGh2SmpQa3ZDckEwN2RYSFZnMGRrVzdacDJBUlNl?=
 =?utf-8?B?TkUzaTYwY1BGYi9QUzlmWmdRNyszaXovS29UQ3ZxU2VMakt0Y01jZGtaV2M1?=
 =?utf-8?B?dkpRcEJ6aHpwbHRoOFdWaVZ2Ulowa0NzbHhvV0FxZEpOeTVid2lCZE8yaWV2?=
 =?utf-8?B?NkZNeWhvL3A1aFMyZEkxTzJncFAxNVlkVXNJZ3Boejl1WXQxa21lS3VUbFAx?=
 =?utf-8?B?Sm9waGFWRlFQU0xuc2N0NCs5aE9sb2NFL215aUxvaklXb1FTOGVGVHB0RlpQ?=
 =?utf-8?B?WnVwK1lRNExCUnJBeHF6WE5IV0lmdG05R01ibUJGbDQxVTFvZEdIVzFycWJk?=
 =?utf-8?B?MGd1RGRkWWJLMnpkTzc4SXZUemd0cW1QL3dDSFU4QkowS09lbGFXbmhsbitx?=
 =?utf-8?B?bTNaUE9sWXQ5aXNZSUFQaWxnUmg4MkJHVkh6TUNiMnI0dW41Wnh4elJTdTV1?=
 =?utf-8?B?cWFYMmNVVmp4TjZuVHpSU3YwMjJOZTM4SVhoOU9BV1ppUGJsdkpaN2NjWUM0?=
 =?utf-8?B?Y3dnSDBrZ05BSHVLWVo5T2duSEdKRE00QldlTjNFeG5SL1IzMm54SmZjUk9K?=
 =?utf-8?B?eS9UdUhtbmRpc0RJcjAydU1lRDFRcllEQURLWnV4cjJVZGZqK3lVK25ndW9U?=
 =?utf-8?B?UVRDRkVEUHVsY05ycFNkYTRnQnc0VGo1dUNVZzU0dTdaV0hDTUFoL00xeVJs?=
 =?utf-8?B?UjVYdlFFRFVBUGxKVFd1bFFIeEtXRDF0dnlmZ1F0eWxLWnpkYitlaHFYYjNR?=
 =?utf-8?B?UUJobEhrc0YxQUN2Vjc4QmdiTHo2Q05SSVI2eGx6Q3NqTkgyUDQ2ZERNSTQy?=
 =?utf-8?B?T3Fnbk1ha0tZakNBYkJHNXFrSVFrVGlXczVxbkY5Z0R4SHRZRmFSQkczb25W?=
 =?utf-8?B?eTdqSXZ5Z3V2eWRQSitOSGpXVGFYVUVlQjJZcE1MN2NHWnc1Tm15K0RyTXFB?=
 =?utf-8?B?U3V0UWNvOElUVFVvaVd2bmpDbGNNRHA4WjZjMGttOUZnUWpyYzVtM292eXFt?=
 =?utf-8?B?WHZISG45bWQ4Z2prcUpISDdkalJ4azlTMy9EbWtBWHpVR0VwWFFtM2tOR094?=
 =?utf-8?B?d2tTMW5pTnFJci8ydnlCaGRlTkoyTHBXa3plSDdTMWhsVUw2OTFGU1YwY1k0?=
 =?utf-8?B?SnN2UjJ3TjlWaGkwY1NBSTJ1YzR0YWEwR2hhVlVNK1FyQSs1ZkdyNnhIM2Fw?=
 =?utf-8?B?Qm9VY2czakE1MTczTFlnNkw2QWN2Slg4bWloVlF4am90MnpFSDYyNjJuOTZO?=
 =?utf-8?B?NW9yTnJ2b1pnT0FhcDdzM1phL0V6WmM5cTNDWksxSkRkdEh0ZXpnSnNhWWQz?=
 =?utf-8?B?UjRhY09DTGhaTlJSRFlremtxUnY1dTlNKzJrMzRheVAzeXY5a1ZRSEZleXZx?=
 =?utf-8?B?Wmd5bEhCdXJ2cFFnUVA1VkJubWxIU3VWUzY1aHNHM1M1YmFLWlRwK1gwVDFu?=
 =?utf-8?B?Zjl3RmxZTHFUc3p5UDY0MEVLRktpbW1ib1hFU0NaS2hQcDg4TmZZYTlKSWk0?=
 =?utf-8?B?M2FZRW9CbUxxc3hmVjB5dDR5TktLOFNqT3g5MVFyc005T21zcU0wT24xWnhq?=
 =?utf-8?B?UnJseXBveU51a3YvUXhYWVZsUW5ZU0l5N2VHeWtYOFNMclFTTWxhSXpuaCty?=
 =?utf-8?B?WkFrKzVOY3VCZjlmRFlRa2tVMnNxRzVmZTBDSCt3LzB5YktEWWhKWmRGeXR1?=
 =?utf-8?B?L1d1YU1sSTQ1QlZEaEFoYWs4UDVXQ0RLOXJnWGI0L3A0c1RLSnZlZCtuS0lm?=
 =?utf-8?B?d2s3Z3BQZjFraW4rNXhvWTdNZ3NJUVF0UmR4a0VuNDdqendlNXVVRDNHZ1pT?=
 =?utf-8?B?TUt2OE9xWnE0TnFsQUdKMnFNalVCU3IrM1BtQTB4UGZPNmk2aDcrS2lKc3o1?=
 =?utf-8?B?cGExV3YyUkNuak1GcVZZV2pzNUhhRUZnR043Y1Rqb3dkaGNKMUZ5WnY2cDhW?=
 =?utf-8?B?cm83c2daemZ6a2R4czNQV2t5OGhtdTlCTjJWZE9EcURkYnhibFliNWRPVmFN?=
 =?utf-8?B?V0UrekRkTmg0K0RKQmlXZUE5V2dhSHlmOWdZOXdLTVVpcEw3alFwb25SdW9k?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zJJM7bOvgAUEfZ03/+3tUeshKNtLtkCiumA8wuFZmNUrIhN/Z1OKOw8V/IQVIhrmQ1adUOfQV0As+kr7p3mnz2emUkZjeAMp3qD1twAqtO7SQwi9q69+2E9ewp6AchR1YqZF7qpGIsdzsMNv2w+OfphmrRAKLcC3Bv3idI9caj3cQOv9lrAF+ewN1I52C+U608+qJiPDB/IwRVs1csEc587kM+Q2tzyI5qEffV4QVXIrTCnFzpnd1fZIXHII4d9DZw06++enZ3VSft2BPqf6eAryWmpJbOxMXUPlld5gg4YJFq2DnrbXGskXT41d3iJGapgbZHZllmZsaTOOnAs0jrLRY/tnv/MZuN1msCe+G7WEkonMaiH6ht8tBNTT4cZpYnA5Mhn12K3qE6PH43JC6KEYan9zo4ZMpnzivE1lN5wIT0yyxji/CdzMeRmDrKA45YMDxlLP8GOW44vhAXVwKDZ/e88i+TB8P0azOT5O1qOxu9MJoutJ5AEPiTsIypjR935AoltZwza7xbWO5zqy9s49Q1jVzDtvJAn3dyF5sWcnWcpKp8JRYvg21nu3kzte7KNn9aCX9NxfskBugmoOuyG479LDBXaMNzMWrIMpcWo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e056222d-e059-4929-7f1b-08dd366a8b2d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 20:15:38.8036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NUQNKqd5ywAGOeDXkeNlohG4zjxx3FP39qwcDzVbwA4ZRWQqkfG+ZpNvkOBVU3LYD7RCVsxtKyxsP+IeSWNUXedbaejRjTttokJKlP3+48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_08,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501160149
X-Proofpoint-GUID: WOrq0OxGTi_HWmAfMd7MuaP_D-QUHqGR
X-Proofpoint-ORIG-GUID: WOrq0OxGTi_HWmAfMd7MuaP_D-QUHqGR
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/16/2025 3:02 PM, Fabiano Rosas wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 1/16/2025 2:06 PM, Fabiano Rosas wrote:
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>
>> [...]
>>>> +    /*
>>>> +     * The cpr channel must be included in outgoing channels, but not in
>>>> +     * migrate-incoming channels.
>>>> +     */
>>>>        if (args->connect_channels) {
>>>> +        in_channels = qobject_from_json(args->connect_channels, &error_abort);
>>>>            out_channels = qobject_from_json(args->connect_channels, &error_abort);
>>>> +
>>>> +        if (args->cpr_channel) {
>>>> +            QList *channels_list = qobject_to(QList, out_channels);
>>>> +            QObject *obj = migrate_str_to_channel(args->cpr_channel);
>>>> +
>>>> +            qlist_append(channels_list, obj);
>>>> +        }
>>>>        }
>>>>    
>>>>        if (args->result == MIG_TEST_QMP_ERROR) {
>>>> @@ -735,6 +751,9 @@ void test_precopy_common(MigrateCommon *args)
>>>>        if (args->start.defer_target_connect) {
>>>>            qtest_connect(to);
>>>>            qtest_qmp_handshake(to);
>>>> +        if (!strcmp(args->listen_uri, "defer")) {
>>>> +            migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
>>>> +        }
>>>
>>> Paths that don't call migrate_incoming_qmp() never free
>>> in_channels. We'll need something like this, let me know if I can squash
>>> it in or you want to do it differently:
>>>
>>> -- >8 --
>>>   From 62d60c39b3e5d38cac20241e63b9d023bd296d2f Mon Sep 17 00:00:00 2001
>>> From: Fabiano Rosas <farosas@suse.de>
>>> Date: Thu, 16 Jan 2025 15:40:22 -0300
>>> Subject: [PATCH] fixup! migration-test: cpr-transfer
>>>
>>> ---
>>>    tests/qtest/migration/framework.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
>>> index 699bedae69..1d5918d922 100644
>>> --- a/tests/qtest/migration/framework.c
>>> +++ b/tests/qtest/migration/framework.c
>>> @@ -753,9 +753,14 @@ void test_precopy_common(MigrateCommon *args)
>>>            qtest_qmp_handshake(to);
>>>            if (!strcmp(args->listen_uri, "defer")) {
>>>                migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
>>> +            in_channels = NULL;
>>>            }
>>>        }
>>>    
>>> +    if (in_channels) {
>>> +        qobject_unref(in_channels);
>>> +    }
>>> +
>>>        if (args->result != MIG_TEST_SUCCEED) {
>>>            bool allow_active = args->result == MIG_TEST_FAIL;
>>>            wait_for_migration_fail(from, allow_active);
>>
>> Thank-you, though it would be more direct to avoid creating in_channels when
>> not needed:
>>
>>       if (args->connect_channels) {
>>           if (args->start.defer_target_connect) {
>>               in_channels = qobject_from_json(args->connect_channels,
>>                                               &error_abort);
>>           }
>>           out_channels = qobject_from_json(args->connect_channels, &error_abort);
> 
> That's better, but still needs one unref for the listen_uri != defer path.

OK, then:

     if (args->connect_channels) {
         if (args->start.defer_target_connect &&
             !strcmp(args->listen_uri, "defer")) {
             in_channels = qobject_from_json(args->connect_channels,
                                             &error_abort);
         }
         out_channels = qobject_from_json(args->connect_channels, &error_abort);

Or keep your fix.  I have no preference.

- Steve


