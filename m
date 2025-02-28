Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA7CC282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 18:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4rR-00072k-Dq; Fri, 28 Feb 2025 13:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1to4rP-0006tY-Cd
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:13:19 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1to4rM-0003Mk-Fl
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:13:18 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SEHEAV002421;
 Fri, 28 Feb 2025 18:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=dChfiLhp3aHPNIX2RvE8TViZypEixXkRZMuzgifox6g=; b=
 mOD7ljcEhAq3VALrwMEziPOsSfgsJ7t3M/d/9uiHwE0n90ttD63b5JRkIspAcpzo
 FYx+5MXF11ZsOyxWp9w7w7WrTZZO66/9JYsQKtMpXTcXpc1yFeRt0agPxwYzZ5K/
 DDVZaQIsq6KutQ2u9NI/mnAo+T5Iq0jAOkKlmFMz3JWHHFBQYPFHJoJvAW+DzQ85
 sfclR51ebOHVPgViFb3sIEB6d8s2D12mS+4y6VC8Akqx2Yjulx+muY9go+qepjCL
 xplxJbt9eDLq8Y7m0EtWiu+9jeasqaKu1hyYrjVXQ1Ygz+AwrXwcw74yO1b77/mh
 ojPqkJsLLYYhicBrE5jomQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psfx3bf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2025 18:13:12 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51SH3t6D012594; Fri, 28 Feb 2025 18:13:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44y51f6fk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2025 18:13:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXlTO4UB6Vvex0+Q6kAo+6Mgp0JqWEZyvk6Jlr0JFiI1lf5KVU++nwIYVHqKZ7RB0szdEXDmxMI4A0hTPkt81anH7wC+6P0XnkPzJ/JPcxoOkXCNJCBBhlBul1jHASyjsP5uGEEY7Z+kbxmMu8f7wYd9Nqa7mrWVBXJ5lQX3LaMvryHKQTQb5b5l/HVhXyxF5FO5IOZsOLLjpkFa628KkOPa5ZVaq5GtB45uAg4d3an+4WCcdesRc623G1iC05Sd0gTVGWIk9bpT441AgMtqZ6z4SKPwUrj3k/NeLxvylrvKfM0NY0NesJnyhMUw9hkfyc7uTUewvk4sQFwNrHFvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dChfiLhp3aHPNIX2RvE8TViZypEixXkRZMuzgifox6g=;
 b=eqTMd1Z2V/s1JRf3Ac/3ttScfUTBIUe2dfNNEhgjV3J1K8Pp8Vlo9byy9df1wCnAbenuBWW2BX2OJ5BAo7qH2JpUHd2coocOMEsGHNhxILgO7MbasLDGKrAiieXZOzYWKJ3Odz0hfHdWUyah5X89r+f84VTYNLTiEhyvJ9aYkOim57ai4odspklomQbUdiT0i6nljxorE6cWq11dr8WxyDFOruDjLmcot3KOZDXJoZhZuqF3bvVdyhs2W7xTs2bxWdsZLUKtwT2Qqa/k5gbzmzBy0UkV6YVe5/MPBVgrM8aO1lGhX3ulZaHikYBe4Fotjvspky3NSfuwnOpy5IZTCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dChfiLhp3aHPNIX2RvE8TViZypEixXkRZMuzgifox6g=;
 b=yG20XdCFeSAsycc83qGvoCfv6NrrwTxwNo0Yum5cGlxlpmPCMaHTFWMmV0HAim+rFtoLlhaOQajh3HNPA2emgU1xNRkyAw+xuWcyWXzTC1ZryzT5GsxLkYfDKxkBEAjLPqXd/5fr7tUfHRqlNjfHmdTC1Uojr+BjDLkOE6sxXVw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 18:13:09 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 18:13:09 +0000
Message-ID: <6fd87c40-92dd-4290-9fa9-abd014ddf248@oracle.com>
Date: Fri, 28 Feb 2025 13:13:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG, RFC] cpr-transfer: qxl guest driver crashes after migration
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: William Roche <william.roche@oracle.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>
References: <78309320-f19e-4a06-acfa-bc66cbc81bd7@virtuozzo.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <78309320-f19e-4a06-acfa-bc66cbc81bd7@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:408:e6::26) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW5PR10MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 207f6604-ebc3-4a42-e496-08dd58238e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGE4YmlaUDBpUmpjQjNTSEJJUWoyUXA2R0hYYUw3dmxXQmlFQVk1eEcvczN0?=
 =?utf-8?B?RjNleTFETFhqK09ONkVHRWMwVUcwanlGSE8wOW92KzlkaFVPc0loQ1NSR2wv?=
 =?utf-8?B?UlpyblkxbDV4eFlmWXluRWFHZjM3VnUwdkMrRzhocXZ2MEVVNGZSOHgzM0NI?=
 =?utf-8?B?RlQxd3B6SlVFMXA4YmFLVjAwZDFUbTZrdXA4UFV3QlN6T1pGWFRlTGxHRkp0?=
 =?utf-8?B?TGZBWEZ0R044WjBvbkN4dVJSV0tDbEswT1U3OXdUcysvZ05iR1J5OWtPNTI0?=
 =?utf-8?B?b3NXVkZ4anFqOVQrVGx6V2pmMGZmbTFDMFZqcU5sS1IyaVR1Qm5RNnRmUWlk?=
 =?utf-8?B?YThnTlRtU29QSFhBMkVZY2ZUNUZFeXh0SlRoNWpleVFrYkVwc3dmcHdQeG45?=
 =?utf-8?B?RFNkakVyS0pyNXhGZC9Ld1ZnRlA5eVpsUktwNmYzclE1TFFCU21tS0dxUUg1?=
 =?utf-8?B?QklwdjZwbzZUYkpHc0NsWktlNjdSOWUyb2gwTFRyZW9JOCtmelk3S0NwLy93?=
 =?utf-8?B?bDFKc3EyUFRZNk5CaTRhc29pQUNTNXg4UVU0QTdvRlhNOWFxMHRFVzNGNHph?=
 =?utf-8?B?K1J6SXIzSTQ3SWYyOXBjR081Q2lhcjhrUDA2YTU1N093UGFNK3UwdXJ0YmFO?=
 =?utf-8?B?VjFjOFFzUXhoblBrNG9QZTZySTZsR0FiaGlZVFVlQ1Jsejc5eFNIeG1tYkM5?=
 =?utf-8?B?bUNKcElrc2R2RVpLY25iNXRWQUxydGdHcUo3QTdTVms5SE5GUUF6RVZTcXRL?=
 =?utf-8?B?b1EvRUFBZC91WHBaQWZvMStGNkRwd0M2RzM5bUZtVkdFRVlycGpjSi9zMng4?=
 =?utf-8?B?anNXUWl5UjFxTWN2eWFsV1crcDI1eVpVM1ZjQkVsZ01HYll3ZU9kd012TzZm?=
 =?utf-8?B?RFJob1h3M1RrTERtYmJoUWE0WjBXR29LQXpUTWZpdjh1UU5ER2U3K042Y0Vo?=
 =?utf-8?B?TWRRTnhQaThYUmRMM2JJc3hmNFF5OUo0U2s2Qm9GbjlEOHM2dEpaUkVEWGNl?=
 =?utf-8?B?UENGK1VNMHJiUmNzZXN2UTkwTGRQRmtrcUJidU0zQ3p5dVJZMVdUZWw5M3ly?=
 =?utf-8?B?d3lNRHBtdnRKTHRnQWVqT1g2MGltbWREZlVIQTloV2tlYzNrMnRwNEtmUmZK?=
 =?utf-8?B?WndPc2VrNEtabXVZY2J0bkRtZGowM2pxaXNodlVlN21TMWNNK2hDR2hzdVBX?=
 =?utf-8?B?aTVZWFhVUjNNek5uc3NPZTU2cHpKNVZ2K01OUUV6UFRDS3l4QmNROGpEY2F6?=
 =?utf-8?B?bldOdmZ3aWxMRVA0dDBmblNVdUVQNEQxZk11aHZDaGIvRE5FS096cUhGVHZs?=
 =?utf-8?B?N1QvNjNtOUxMVDFtWVlQaUtHcWNQeVRHSi9na05Pc0t2dElGV1VLMlk2ck40?=
 =?utf-8?B?a2V5LzduVVNhRFIzMno3MDhZdEdkcDJOL0F6OVBLYnkrZElCNnpsSnBuOER1?=
 =?utf-8?B?Q2VJRkNTTDV3R2o3VXVQYityYm5Pcno4VmFQeFczQUgzOU9ibUdPTHdBY3Iz?=
 =?utf-8?B?TitRM1pieHpkOXhpY3VUbHNGRXFLaENTOGordDEwSFY4MGh2TEV1bTgzc1Ez?=
 =?utf-8?B?WEIyUUJMQWx1bzhYbVpzUEh6UndkVDg4SnVWOFBuWVBucG8yYVpmS09XSUlG?=
 =?utf-8?B?dGlyNnl0S1dzS1p2eXIwcmJyNkRJLzd5bVRPbG5SUGFFZGFxb0lGVWJLbzk0?=
 =?utf-8?B?c3hBOFpkWFRaaVV2aGVTNWVFNnQzeDdBemRDRXpUYXZiVWdmU0dOOHcrQ2tq?=
 =?utf-8?B?QjRQVHZiWGxzMUlvWlFBSGNNcWhZSjQ1ZDFPZDdERXFnN2xSNjJFZ0MzQ2pD?=
 =?utf-8?B?NEdTSTRJejRVOEpsSzF5Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGhFeTIxTlAwOGx1S09xcW5GbW9LNWZXRjVnNVN1ZURVaXJXNG1xbEg2cUcz?=
 =?utf-8?B?ZXAzWTFSUlBvekIvME1yN2xqRHJ1V3JpOGRFMDUxTVpScUltTWw5RThtM3FV?=
 =?utf-8?B?VS9Obm1sUm1VWmhGeGZQb1dXNEYyS2hxbFNOZHdid2p2a2JLWlVUNnpsVzVl?=
 =?utf-8?B?SzAvSFhqNmtndEpvUGdYV0cxbFJQMk9OdW5GVzdLYVN0ZkJEdEllQkRnRUgz?=
 =?utf-8?B?ODU5MEtNN0pUZlBFcHU0eE1oV1ZRejR4a2NnQ1dPZDBJVW00aGs3ZUxCa2ts?=
 =?utf-8?B?VUlhY0FXekIrL215ckVDQ0M3Z0RSSTZkWVBtZGdDd0hqVWFJSC9TNExVY2Y2?=
 =?utf-8?B?Ly9iUmZueFRQb09BR0lIazJ5OUV5K0h1NHVHZUpzNmdUUnZUVnk3MStkQzJ0?=
 =?utf-8?B?dnRZRWd3M3poeVFyVTN6NzcraEt6SFdSVTlJM0hjQWVmcWIrNzV0bldsVDZo?=
 =?utf-8?B?TWJubUlBNFcyQVZJdVo1TlJ6aDhvR0RyQWtXV2RKaUlnV1E5KzJySEx1YmpR?=
 =?utf-8?B?RXNibzhjTGNTMzFtQWhKU0U1cUtGd21XZ04wMWhZaHRwTjFoNXo5dU83RTk0?=
 =?utf-8?B?K2FqT0NKRXFubnZMeWg3M3RzcWt5czgzeVc3TGpTNTk5NEVXUWdIcTlvb1Bi?=
 =?utf-8?B?eVZtUDY4RzR5NHZzTFZwaTJ4UWJMdWFjZ3diL0xZRjZ4MG1DNjYwU1RwRHpu?=
 =?utf-8?B?S3o0YjBTdTBVWjJVaWs2b2dyN09qYnNSa2EzM0NnS0FaaHRYNlJsL2dzUit4?=
 =?utf-8?B?My9WWW8zZVJNa2ZpdndHcGdiWk0vSitGV1p6UUl6Tnpua0swdFVrQ3NCSDJH?=
 =?utf-8?B?UExtKzRVN1Q4ZWZzRjdSd01qaVpIUDlUN3pHZ3drQUIrNHNpUjRrbmxBREJ5?=
 =?utf-8?B?OXc4eURzOU5RWkRuTFVwTkVKYnUybU9tSW01RXBRLzZTSjhTU0FsVmF0N2wx?=
 =?utf-8?B?ZkNSTHFoVFBqcUc4M2s4dWd3WmZjUUJ2MklUellBMXZOWWZ0OGllamVRZE40?=
 =?utf-8?B?WHRKSTZqQldKZkxsOTFzT2xDUkEyQ05NNGpKM0VXUWNQV3FCVE5WQ2xBMzZk?=
 =?utf-8?B?SzdGVy90MnU4d0NGZjB1dHlNNTdnRkdNaGV0QU5scXRjSmxldUFFNG9JZTE4?=
 =?utf-8?B?YmlMakFsRi8wQ0hjcUV0MFdBcGUzSWljZlZDS3dwTzBhb1hoNXdaalZGL0VB?=
 =?utf-8?B?Y3ZBOCtCa3dablM4V2kwcmdkY2swVFNGai9TbG5jT2U2eWtaeWowWm42VGRh?=
 =?utf-8?B?NnRnRHhHQW96aWp3ejNQM1NlZkxGMUtIS1NXSG1kWG1uWkhuNWFRajZGZFhQ?=
 =?utf-8?B?WTUvUmtYYk55OHdhdjE4ajA5eGhSWTZOSVc0NElaNmhkRGMrTWRCR0JlYnRL?=
 =?utf-8?B?SklTQ1NKam8vWTQ1ZTlxMzhhUEdHVEx6K1dZNUw1YnorYlpNQUh2ZHlCeHZC?=
 =?utf-8?B?OU5qV0w5dENaL1BUdVlaSVhaS2JFN1E5VkxGR1BnbVFJb0V3VFRzQy85QzQ0?=
 =?utf-8?B?dUtmMUZTTWhjSVpuTHRYbXh5c2E0bGJUYXZ1Wlp3TFNSMjB1L2FjTk8yQ3Jy?=
 =?utf-8?B?L3dDR29JY0dpSzM4dWFLOEVTUXhvS3VuSmxIYW5pVWFjRGJWK08vNnkwSHMz?=
 =?utf-8?B?Vmx5ZnNpS0h0bll0RURmL1gvMnI5Q0p2aEpzU2I3dGpkQTYweDlQSTRoMVlW?=
 =?utf-8?B?c2c2Y2JCQWhWdWF5MGl4NEs0OHp1VklHV1pZUU1FdmVndFZvT3RHZFBBY0x3?=
 =?utf-8?B?a3VCUC80QkdKcWpRck5KNnBOZnI0TWNaVS9aeVZ1Nlc5SC9kaUlNckc2Nm9P?=
 =?utf-8?B?K3c5dnNLc0YxYmxuVVRhQURUYk9QNFNaelg1QzdUM0hCS0ZzVzdpUHpxc1RN?=
 =?utf-8?B?MEl1aHB2b25aRENtZDhIM2xEblhPOUdZcEhOdDNzbldDZlQrY2M3Ty9ONmds?=
 =?utf-8?B?alZvV0wrSTAwaDFxN3pHVExGY0F0bVdVVll0d01TZExtR3Z1c3BFdFU2dlc4?=
 =?utf-8?B?WW5tTHFrZDIyTmU5d2Z1Rmt5RzZyTHZyNlZMOVluYTJ6bDkraDNaM2o5UFk3?=
 =?utf-8?B?YXpKVEU0K1dwYk1DcFIxYkdwQjBGZnhhU3lTeHgwbStKNW9YRDZMc2s2OVVo?=
 =?utf-8?B?Q2tSZkxseGhWRGI0TWFqa0dZY0lhb0x0dUhTZFVhZk9UdkdzaEx0TjU2NVRy?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Wy74ZftO17z4gtyOylOeh+7aMNH2xdrLxDZFwlWjXqyH2r1NL116m3kAS7pGnRCVSiEopBpMZfaHmz31xhsZfjd2R7BtSd2NuVV9VDWTd9aw7ySZrBeuosrE2LB/M+FR6D/br6guy2eSy7fynDA1/Cc7UMtt/NKh5b6K5cXxVsI8ZQfUrfTA8WVfmhzeMPPmQSv2w2w/3kZSHViq0EdyG3HG5fXr6F5KCP1+whXwSOTsJU5HlE8LcwBChdMRN0h58nW7u2TlXVFoerc3qFoj6N+D/6MMftLBFr/6aqmHtMeHsh6gPbmWdi5dRH2FZs6c0TVc3R4/pLzA4RB4Imf0kbCwh/HiJUOmvmPzeDgGn/SNkSvE1SmZK2pAGLhHxgpIm31nWnND6NwsIdyi5Rg4u2+3IjhCYT2+f5kIkwzl7YYKH2t/qwqcr4m+b2RDzIoWuHufU0jHjSLsAMjUaROmVVfk+/d3eRJMIxeeiGHaJrbJn6C4tERMNM0/ljent9A85BzIBA2ajajbbbthzSG/d4tMpADhkfMdfe/6jp3H3DMThdBAfIWWpF9vuv45ps2H5nUHeD/CSQD9tot3EucNOGKtNh62+kQUOy5Q6bWkCWE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207f6604-ebc3-4a42-e496-08dd58238e69
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:13:09.4292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POJ/fjUVqv4AZgS9Q1Xllu5Ey3QEV+zu2uG4TXFMcBAtYw4/ZBv9v/cQeQDyUezh/5/tg2sQGPZJ25XwmEfpcZsT25UVhJJyKA4bWtwI1+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_05,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280133
X-Proofpoint-ORIG-GUID: 38kPUo0WK3VeP2t_AvegUbm7VmZ-Iy1Y
X-Proofpoint-GUID: 38kPUo0WK3VeP2t_AvegUbm7VmZ-Iy1Y
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/28/2025 12:39 PM, Andrey Drobyshev wrote:
> Hi all,
> 
> We've been experimenting with cpr-transfer migration mode recently and
> have discovered the following issue with the guest QXL driver:
> 
> Run migration source:
>> EMULATOR=/path/to/emulator
>> ROOTFS=/path/to/image
>> QMPSOCK=/var/run/alma8qmp-src.sock
>>
>> $EMULATOR -enable-kvm \
>>      -machine q35 \
>>      -cpu host -smp 2 -m 2G \
>>      -object memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/ram0,share=on\
>>      -machine memory-backend=ram0 \
>>      -machine aux-ram-share=on \
>>      -drive file=$ROOTFS,media=disk,if=virtio \
>>      -qmp unix:$QMPSOCK,server=on,wait=off \
>>      -nographic \
>>      -device qxl-vga
> 
> Run migration target:
>> EMULATOR=/path/to/emulator
>> ROOTFS=/path/to/image
>> QMPSOCK=/var/run/alma8qmp-dst.sock
>>                                                                                     
>> $EMULATOR -enable-kvm \
>>      -machine q35 \
>>      -cpu host -smp 2 -m 2G \
>>      -object memory-backend-file,id=ram0,size=2G,mem-path=/dev/shm/ram0,share=on\
>>      -machine memory-backend=ram0 \
>>      -machine aux-ram-share=on \
>>      -drive file=$ROOTFS,media=disk,if=virtio \
>>      -qmp unix:$QMPSOCK,server=on,wait=off \
>>      -nographic \
>>      -device qxl-vga \
>>      -incoming tcp:0:44444 \
>>      -incoming '{"channel-type": "cpr", "addr": { "transport": "socket", "type": "unix", "path": "/var/run/alma8cpr-dst.sock"}}'
> 
> 
> Launch the migration:
>> QMPSHELL=/root/src/qemu/master/scripts/qmp/qmp-shell
>> QMPSOCK=/var/run/alma8qmp-src.sock
>>
>> $QMPSHELL -p $QMPSOCK <<EOF
>>      migrate-set-parameters mode=cpr-transfer
>>      migrate channels=[{"channel-type":"main","addr":{"transport":"socket","type":"inet","host":"0","port":"44444"}},{"channel-type":"cpr","addr":{"transport":"socket","type":"unix","path":"/var/run/alma8cpr-dst.sock"}}]
>> EOF
> 
> Then, after a while, QXL guest driver on target crashes spewing the
> following messages:
>> [   73.962002] [TTM] Buffer eviction failed
>> [   73.962072] qxl 0000:00:02.0: object_init failed for (3149824, 0x00000001)
>> [   73.962081] [drm:qxl_alloc_bo_reserved [qxl]] *ERROR* failed to allocate VRAM BO
> 
> That seems to be a known kernel QXL driver bug:
> 
> https://lore.kernel.org/all/20220907094423.93581-1-min_halo@163.com/T/
> https://lore.kernel.org/lkml/ZTgydqRlK6WX_b29@eldamar.lan/
> 
> (the latter discussion contains that reproduce script which speeds up
> the crash in the guest):
>> #!/bin/bash
>>
>> chvt 3
>>
>> for j in $(seq 80); do
>>          echo "$(date) starting round $j"
>>          if [ "$(journalctl --boot | grep "failed to allocate VRAM BO")" != "" ]; then
>>                  echo "bug was reproduced after $j tries"
>>                  exit 1
>>          fi
>>          for i in $(seq 100); do
>>                  dmesg > /dev/tty3
>>          done
>> done
>>
>> echo "bug could not be reproduced"
>> exit 0
> 
> The bug itself seems to remain unfixed, as I was able to reproduce that
> with Fedora 41 guest, as well as AlmaLinux 8 guest. However our
> cpr-transfer code also seems to be buggy as it triggers the crash -
> without the cpr-transfer migration the above reproduce doesn't lead to
> crash on the source VM.
> 
> I suspect that, as cpr-transfer doesn't migrate the guest memory, but
> rather passes it through the memory backend object, our code might
> somehow corrupt the VRAM.  However, I wasn't able to trace the
> corruption so far.
> 
> Could somebody help the investigation and take a look into this?  Any
> suggestions would be appreciated.  Thanks!

Possibly some memory region created by qxl is not being preserved.
Try adding these traces to see what is preserved:

-trace enable='*cpr*'
-trace enable='*ram_alloc*'

- Steve





