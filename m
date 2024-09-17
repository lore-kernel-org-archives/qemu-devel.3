Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A604BCAC58D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 16:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqbE4-0003tM-Jy; Tue, 17 Sep 2024 12:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1sqbDz-0003hK-JL; Tue, 17 Sep 2024 12:38:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1sqbDw-0008SN-6T; Tue, 17 Sep 2024 12:38:47 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HEMjEi016219;
 Tue, 17 Sep 2024 16:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:references:cc:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=vI69MnIFazokmiteV/ryVIuhcmz3tf5RHoj+SuxxgmU=; b=
 Mpd9jK3VDzZqRAaXQheMWrKVBm7vMzzPeLPAynjwXjMKmZU22RpxMWut72Cy/rix
 u2UvrN+cqbZxiawI7s9d1DDkD3bQKcf8T8sld4qnD4l2nNVENaVJg7t27qYJ2wqO
 a0P8akeWh5yv1VClOyvKb6uVYb8sdrfDXEwD0c5UEfs1kSoByFiO5voEsNtVHyhB
 OiD/ckGK478mF464uJ1ZFuXYFFmZ5X/DTo/32RVie9LB8CWlASOUqhaUWNUP8bmZ
 pMHfGy8WTzLYJM4f8ecXHUmmSsD8OXQKDhSMZgvafrFM8dJ27K71wJu7wH6uXgfY
 0+Ml/qxwZX6e61CsZN9ChQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3pdpjm8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2024 16:38:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48HGNmkU018222; Tue, 17 Sep 2024 16:38:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41nycwvg1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2024 16:38:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gI2IPyK9eSnh2LbaYrSXRdPR5Po4ahrYiCVZ7KJvjPJkp21rb4jwyRp7eCItrKy8w3I+1loA65zgU8EnetnaZwa3W4efWeolmz2E3hZsqWlogb+UUea1m6fUOrpr0/491ewswBjVnIUjnpH8aAZVyDFtTi641bTUQqHPFa4tpKqrztroNXO8lvcndmlHHdj8Y2Ya3clHzDKN4NC6f8SGRzmZg3oVzkWOwqFvrzSOpdQYiBUIbat+RBe4nNcAydT7FGTAo/Mj+4WymieUB0+VIOFJ5W/vwPfP1dJoz7eE6DFBhkgw/7AKuupFhuyGpBXjiO75X7Q+RRW2WQLIXAbIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vI69MnIFazokmiteV/ryVIuhcmz3tf5RHoj+SuxxgmU=;
 b=q+ijI8YhnoeljaG5iy3eNh6SZilzUeJbMdc2Br1MWMJAIg2slpeeXk9DX/LHt9jBMt3EToXpJExFz25IXdHfq6B07V3nwr9YFiCdLNTurF0JkXsGzjN/TlrmqLBtWMlkOsC6CdiMH6ww5XH5sDB+ncoAJiuQplOG/+JDHP79u0bfzuLympBpXgb+ZyhmfP8+pMirgICJi6fyDJqA6z4nyKE+adag8bpQCqqym+Hiuli05H4RzGxEP1T1977ZQzvK1aiVjCYxArpPQe/tOIfNXFuWTKOGfgUONJE1RR9iaPvotSegClBEv7nUZ/IB6kCkV1QofowL5ArjRamOd+8RQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vI69MnIFazokmiteV/ryVIuhcmz3tf5RHoj+SuxxgmU=;
 b=AtopvvpjvwIHMfYJ2dizRu7AddI3iUS+GLWrCDTJRUFschSf1Y4vblWa7YN8/pWibwzgqx0LmAwi3IGvS5yvQKeXMmW3VcAQjIqHmE/ORhXF+EM6oEpjmIWyqvFt453/N9XYlFqMZIRXNX+D9UF0Yus3TLRBNV6I1WK4jpcr4qE=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by DS0PR10MB7052.namprd10.prod.outlook.com (2603:10b6:8:14c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.14; Tue, 17 Sep
 2024 16:38:19 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%7]) with mapi id 15.20.7982.012; Tue, 17 Sep 2024
 16:38:19 +0000
Message-ID: <ebfbedb9-8c93-469a-a101-c6b82d60302e@oracle.com>
Date: Tue, 17 Sep 2024 09:38:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] hw/nvme: add atomic write support
From: alan.adamson@oracle.com
To: Klaus Jensen <its@irrelevant.dk>
References: <20240820161123.316887-1-alan.adamson@oracle.com>
 <Zuk24CCgPIZgmN1e@AALNPWKJENSEN.aal.scsc.local>
 <53d53e7b-247d-4546-8425-8bfa8561f907@oracle.com>
Content-Language: en-US
Cc: kbusch@kernel.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
In-Reply-To: <53d53e7b-247d-4546-8425-8bfa8561f907@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0232.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::21) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|DS0PR10MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd54e67-c01f-4600-ca76-08dcd7372348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVNBQWtOdktMano5TG9BVlk1UzZ3WlJXQlBBWFVXdUQ5RmQvMy9BWXFIR0Rh?=
 =?utf-8?B?K3hyc255NVp4bEo0RjZkb3lyWXJrSHcyMUZXTk5BV2FFSTZqZFdjMjV5QmVn?=
 =?utf-8?B?U0V2UUlKcGkybGRjVzlRZjJxeXRsUUNHZFFhb1k5d2I5Z2JvbHI1MjlYSzNy?=
 =?utf-8?B?Y05uczhUY0VWUW5ULzRtbFM5dExVWFVNYkMwRjFLRTErNHJ6MlFpK212aGlI?=
 =?utf-8?B?K2dpeGNuNURzY2J6OThsTTNBd1FVdkl5NnZHNlpmZXVsUklvTExmd2JsaVJ2?=
 =?utf-8?B?dkNXeTVsdmdac2xGdzlxZTg4Q2I5OThWR0I5OEl4WVNvZTNRejFudEtMRmFT?=
 =?utf-8?B?ZEhUM0NMRExtN21UcUZhOW5aZFJwNVAxTUM4WTNWOEJGY2M0amUxSWZJcllr?=
 =?utf-8?B?UnJiUllsSXBzbWZ5M3FqV243NVMxbEg5K0ZBK1lZMUczWkdBRjV6UDFhVjF5?=
 =?utf-8?B?M2dsUTZkNERBOXArU01Td3h6QVR4czRYdzd5QnFsNU5PTG5pTXlqZmgxT0lv?=
 =?utf-8?B?bklBZ2JTNHRDV2F0MnplU0NZYlhJdm9peENRcXZlYUtjeDdBeEdSMlFla0tS?=
 =?utf-8?B?VFZSdkI0SnBTUVQ0SERDZ3plSHVlZGs2cTNIZTkraFdhTjcySlQreWw0OUE3?=
 =?utf-8?B?emxqMDJsR2ozVStxMDhNM0JGZDJ6ei8zY2tEVHlIOUxJLzk1K0VaWnhGUllX?=
 =?utf-8?B?MThKQy90VkF1eWp2N3JxOG1XVUFUaDJzdytUbzcrbXdVQ2dwQTBSelB3K2NU?=
 =?utf-8?B?THZQR1hKa0JsaWY5N3gwTWVnSlJtZkNLK0lJK2ZuZHpDQTdweHdHd3Z5ZjV4?=
 =?utf-8?B?QzhZUGJaclJGNFJCalZSTnd2WXdhcUJDME04eWI3YmgzZzZwbStwUWVEa3Bz?=
 =?utf-8?B?RmwwalplU05UN2VxbWRuVXE0eHZwZldXSTNuSHhlRGJHNFhNaGdIV1hJaWZp?=
 =?utf-8?B?ZUNWRmdRWkYyaEYyUmFRdlM2Uzg2c1UwVjRrWmRkblV1U1hjSjVwcklWNGhq?=
 =?utf-8?B?bVF4dW1Qa3pDR25La0FRdFEyakFCelZZQXlrUGpEWHBULzlSQ3habE50MGVa?=
 =?utf-8?B?ZktJUms0bmdRU2RKMnF2MW9yclVNK0NDU0JuczdvZUxHUitIQVFzdnJPc1Yv?=
 =?utf-8?B?UWEyNW4xa0hkTHBJbjU1ZHVLazlmTW0wTWN4RE9UL2pWTjZrOXh5Q2hwUkxP?=
 =?utf-8?B?dUNmMkF3TjBuM0xKYWxhM3hwTEtVenNHenZNaDU1NHBvcllKSVlEWlRLZUdM?=
 =?utf-8?B?SURoZUs4YVBxRlBnMVBMZGV2bXNHaVd5T2k1cnNIOTlIY1BKMXV3MnVsNXo5?=
 =?utf-8?B?Q3JFV3M2bUs4L1RMbmdBOWpnZWpaeFNQeEh6a09NR0hNSkRZVXZvUDdhV3Iy?=
 =?utf-8?B?UHdPbERhSGswK2N1WlRIeUxBdHhLaFZDUDdsY0FhVElWQ3J6dDBkaFg3Z2Zv?=
 =?utf-8?B?RjBpVDI1dGVyRG10RTdZdTNtakdydU1xZ0xvQ1JYN0hmZGdZWmFqT0YvbHdR?=
 =?utf-8?B?UUk4cmk1RzZJQWwyQkdyZzZ2QmtJQXpNV241bjNwUElSMDhTdktCbkN6MGh6?=
 =?utf-8?B?ZDNXSGN3Q1NyQ0hnL0FOZURtckk2VGJ6VjU5dEYwT1hsYnFEUUFUa3BPMk1K?=
 =?utf-8?B?a29lNUJvV2dZbmFXSlB4MEVCOVRUczRqM254ZGZJMXZ2WVUzSzUvbkFZNG5L?=
 =?utf-8?B?azNlbTBEbWxQdVVjR1doSHVHWlkzTnVSM0NJTmdTb3ErNk13MUJ5cW9maS82?=
 =?utf-8?B?dmlqZk4zSTkxNDNHOTlPdHExb0RYU2hKK3VsMFJ3dC9WUXBMYWgrYnpPQ2dk?=
 =?utf-8?B?UDI3Y1gyUnE1b25FaE5Fdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnArRlVtQUpsUTR3ZUh6bTd1cW9waW1rSGVDb0VTUERKVzlmenloQ1BxUGx4?=
 =?utf-8?B?VFdPY1V1S25zalNiaU0wQVNLejI4cVkzcGdGcnhJTHVyUWFoYXRuWStVVFpj?=
 =?utf-8?B?MHZrNTZhSnd0dlJ0dlVlRnBsZEtUcnBmVnVLN3lwUEw4YlZsWWNtaGRGYXN3?=
 =?utf-8?B?dFp0YloyNU9MblpsbXM3dXhrYi9OUFlzR2JBeGVrMmtmY1I3M2wrUGhSNVE1?=
 =?utf-8?B?dHYvWTcrT3lpNkNmc1VBeDA0UWtmL01iaUpzVWJKVUtZc2hsam13SDNtcS9k?=
 =?utf-8?B?TDJnVDA5aDQ4S0ZPcmgwcGZXa3FjR3NYeUQxZ21Fa1BheUJpUTdIS09GZUtH?=
 =?utf-8?B?SHdoZy9oNEV6WElYSytiaGpoZ0FkUm8zUDk4SThLY1F2b3BMTmtjZkJ6N3dM?=
 =?utf-8?B?dVZZRjZsb1V5dHExL3hNTGc5alp0K1BFcHYvc0xvQnZXdEpnaDl0MHZVOWJL?=
 =?utf-8?B?aHZIQ1ZPNDk5czlQTEdCek1UVEtlNFBDOW45RlBOcjF0RGh0NitySDdhVkhG?=
 =?utf-8?B?WncwcUx0SmdRZk4rOVBwRldtUjVWdG5FWmUxQWFlM1NYR201UVBDbHF5aHp3?=
 =?utf-8?B?eG95YUYvdFFYZUJCR1ZweVBybk5yWm53a2lmSnRYaWgwQVp0dHBCOFNLOFVM?=
 =?utf-8?B?Ulg2c0M2b2dvcmdPRWw5cTJtOXA1TWV0Z2R2WWg0ZUhEczg4S29tSGpaajNQ?=
 =?utf-8?B?dVlBNU4zSUhHT3Y5c2JKZGdwcUFNM3kwYlhhcXk5dHV1S2JSQWRON0Q1RXJL?=
 =?utf-8?B?U2RhQktGOE9IZEtTV2M0RmJZQmgzWVlweGNJT2NwbHhtU3VYcnFwOVRpc0xH?=
 =?utf-8?B?ZHRxV2pvQ0JuQmhaeldvb0NBMExmSGVGRHErekZnUU5hUmFzcXh5VDhUcVdl?=
 =?utf-8?B?UERYaUFkR3grZEJpZ0thQ0hud2ZIVkFwa1F6S21Kb3V3SmlzWGYzZG1SdXVu?=
 =?utf-8?B?U3VzODhZVEdCSExiNktENEZldWl3ZGRGanVZQ0RLYnpKSm40YzVpMHBhbXhJ?=
 =?utf-8?B?OGdQT01rQlJWT21KcWIzWVZaYWwwZW9BT1I4ckFvS2dVYXRSYzBCU05HVnpM?=
 =?utf-8?B?Qy9LdmdYeXZVWVpKd2dDZmQyZTl4ZGZESytWWkhQL3dUb21XdEpFaVRlMUlY?=
 =?utf-8?B?QTZKU01OZFRDTDVvdmsyNTlZN2RDc2t0elVlVjIreHZ4L3V0dWJiZFFtZUtR?=
 =?utf-8?B?OU80UVpLUnNFSnBNd1VSUGhDdVRtNHdFSzNQZWlHM04vclZyejJoayswa09t?=
 =?utf-8?B?VVlMenFucDR5cmw1b3V5UVBWeFZjUTBSK1ZzMWNMMkJoQnQzODNQMGc0aGxv?=
 =?utf-8?B?UGhuOHFTaGFjWkJjWmZxdlZFUnl5YXJuSnJIUlBRY2hJc0pHNlBWTERHdTU3?=
 =?utf-8?B?S2FvK0tBL1RiOUh2WWF5ZWxFOTFlbFV4ZndSNGU1bHVYUHZBanFsVGc1SE83?=
 =?utf-8?B?MFM0YjZFWWR1b2dVSjNZajVPMlNVUXJHQWNpQzFiajg0eWxzYS9jV3VTMkl6?=
 =?utf-8?B?TlZnd3RRTTBmaTVGNkdNM3ovS1dEbU5YeVpLS1JDTzk3Qm1SYzlFWTBMdVZD?=
 =?utf-8?B?M0VRZWJoTVdyNmtyWnRFMVJZOUxsMlFDVjhkTVhwUU1sWmVVVTVZdFR0TGMy?=
 =?utf-8?B?TzRxM0RIOCt3ZXdtOTFxUVBVNUZ1a2UwZ1JTb1dTTjVIM3c5UXdHUEVMREEz?=
 =?utf-8?B?RWprVzRoTEU2S2hid1dqMXpTWDlZT2MyYzZXUm1UTXIxR1VaODYyS3owd3Nq?=
 =?utf-8?B?NlZPcW5pYWZjcUtLbExSbCt3Y1pzd1lYZVVla2JPSTVhM0dUeGdsQXRCWTFm?=
 =?utf-8?B?SlcyWFFpelNLVVlnRkZUYW5WbWQ4cE1Rb25ZRnFGOGk2ajI3dlJVNEZuaEhx?=
 =?utf-8?B?OWR2ZStDdCt5STJaM2NadlZkeDVkQkZ5MHNnekYzdE1MWWZaS04xaStQNE9n?=
 =?utf-8?B?YVZqakFMUzZ3VXlOM0J1aHZCY255c1VyYWRkSXRVdFl1aDlTQkJyTi9hTEFY?=
 =?utf-8?B?Nnp1eTRQRHJlL1B3dDVMdFBXbENUK2pkemIyMmNldWhsRXUwRzlNdzZLM1BN?=
 =?utf-8?B?NndkTTFXNnlUNG84SzRSSGpCWnNpdXozMy9sdURqbDQ5aUdpRkFwMDZoTFZI?=
 =?utf-8?Q?39tQDeVQoMX/MLLsceiRoiR7Q?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cWIdxTnTr0FVcBsla9VuMGCBySsh8EaJ52nXzWruv+w/ihp6Q1rC8aO9Neiaow7wWSFuYgqfhu2hz2D319D1KyB4O/ijMZnqsjzczjP6VHHkuVLC3qQspjKFwpiWU7CPywPXJryjC+bauEMbtIGLZ2hwKUW2tgOCcF9dJafDSfDbyTogDkKr8x0/H/6Bnruu46qPVZN0fuz1UJ78TBSwpapYJUfvLeZOXIquZRGNCtKzt1w/VNM5QYSRHwdsFdg8e/6+cWUaEjl4gM6q462QfhrTuApie3lYyWJM9VXBmU1+xszpH2n49Lp740fAfkdBd58P+grQEey5DNX5HHzDzflFQSx+U2zQTvnc+9A1rolegD+MrobiDFQZ/b+Gkwfi+a9mxCfO/+kGxy+wcMZbBTNrTyDGnt/ylXiDmt+0afh3x8TNzr+eFIx6Xp1vkbO5cvzIosDPgt6KHNEVI+lZzuoPbqMNszBVvNvTRC6KEjCJroHJANWEt1NYn8fHyoSifGpXdw7JXxq2nQ1SBCL7tbRKgzlWVNz7DryyR1RL3HydALhh6L9XRy0quTF9WTZGfMU69sxo6vQDmBABvzAI7FHgm5sCSNEd2gD6a3K/PfI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd54e67-c01f-4600-ca76-08dcd7372348
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 16:38:19.7307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JyOYhJE0zT9eVjvyhpj6Wj1j1LsV9qrhqaaqKR5UdmOJLdkdT3uGWHKsLUfAUxnUbocw2h2PuawILAQV0G4uiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7052
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_08,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409170120
X-Proofpoint-GUID: h1auR9TUcxW85uSm9irVazhkDuOochv8
X-Proofpoint-ORIG-GUID: h1auR9TUcxW85uSm9irVazhkDuOochv8
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0b-00069f02.pphosted.com
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


On 9/17/24 9:21 AM, alan.adamson@oracle.com wrote:
>
> On 9/17/24 12:59 AM, Klaus Jensen wrote:
>> On Aug 20 09:11, Alan Adamson wrote:
>>> Since there is work in the Linux NVMe Driver community to add Atomic 
>>> Write
>>> support, it would be desirable to be able to test it with qemu nvme 
>>> emulation.
>>>   This patch will focus on supporting NVMe controller atomic write 
>>> parameters (AWUN and
>>> AWUPF) but can be extended to support Namespace parameters (NAWUN 
>>> and NAWUPF)
>>> and Boundaries (NABSN, NABO, and NABSPF).
>>   Hi Alan,
>>
>> I am trying to test this with John's atomic-writes-v6.10-v9 linux
>> branch, but that does not seem to work for me.
>>
>> Do I need anything else?
>
> Hi Klaus,
>
> What  are you trying to test?
>
> You can see if it is being setup properly with:
>
> [root@localhost ~]# nvme id-ctrl /dev/nvme0 | grep awupf
> awupf     : 31
> [root@localhost ~]#  nvme id-ctrl /dev/nvme0 | grep awun
> awun      : 63
> [root@localhost ~]#
>
> With or without John's atomic support, for this case, 32k writes will 
> be atomic while 64k writes will not be. This can be validated with fio 
> since corruption is observed when using 64k writes.
>
> Alan

BTW, I'm going to send out a v2 of the patch that includes your suggestions.

Alan


