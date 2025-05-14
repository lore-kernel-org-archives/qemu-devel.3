Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5242BC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 23:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFL5a-00068g-Vp; Wed, 14 May 2025 19:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1uFL5T-00060I-ES
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:00:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1uFL5Q-0007Rx-ET
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:00:31 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJkm1H011554;
 Wed, 14 May 2025 23:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Z+xjoOv1NUS2+NnCZ947qIOUWLakEDCS2vmzrvlGO/U=; b=
 PRk+Y/1Yfx8K5YyozEoLQku7dJDOIUSwLLoL3qH1a/zTNUiIEWZMvNx7wFfi2dyK
 nUlIGpZiHme4wusvPmbX8xO+aKWU8OWhgqNkwFzl1nz/WwAbxqd2nQ+sg+HlVjM0
 PtWo4+eO8cokFvJEN3o6C8AH6GoqV/ZwaCP9rk/yzNI6BQp0UUxKEMc4pwJqlNQd
 w2kBg5MzkvWImkmUi5iBlOus+GlnrZeU2sPVKuDiKtn4xrg3fj/r6AYte6lWVTUk
 ipZeIaBATU/2zwYl5MpitM/ofqb+hsGYkXPWguITOUg2mniwXEBkBvVorHQZ94m8
 ldBqBZwpdYdoGPWIfeYgog==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ms7bspjp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 23:00:18 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54EKPoTX004444; Wed, 14 May 2025 23:00:17 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46mqmcpetw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 23:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfQRqNlft72DDSDTTxBIt/bHF9TY7zumfqo1PqBYqkvZ3Y3qjXkKbvETXzDaPs0qmCjXqJUoNwG+M2cUKSbrYFEDvg4R80FHbYVPfWc2v0De8fsGUVyX5B5yzkzZ19Gty4yUG9ReAK4tC6DEE262IHyB+3pQk7dLXYMMOiEdxguRDAnM87Rbsp2RgQOE1t3fyRZvMPPcp5PquMp0Sy52R0UG9tlvgqrOLcYl+MM3ORIA2UN0fuRJIDWMFCLm1FHNFqSCiGgWeYCXUe/M9Yw+YAYiSKwOwBvMe5JFFRn+6a9pGmfau91N3CfUvD2PDRA2QHCkjY9nV3xMqrT5wdxZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+xjoOv1NUS2+NnCZ947qIOUWLakEDCS2vmzrvlGO/U=;
 b=f0duRX0Y5Zodcdh/zfGHFDl0b3QzrgfuuZlhhs10yESl0quFVE4JtU/QELyhPmy6WnQr7g299+gFxlANIiwPenzcLy+eklBXDGGz7pjN+sMbyb6Rtmr+3e2h+t2dJukpsnRmOXG6wpaYsmy09dMBCt7iK7/EM7/+VU3CH+lKnFqa3IoTEnITwDFyfREH4SIxXwDU2NxrGNlv+qWEIz5THNWxLuqE+zx38xQ1hDgIFKzLVV3QRChLOC0G2NS8OV/FWbvBSN93nSMZaakFTOnGPjBpv9kXoZFSbG6iL+KMjBeLOohkYrYxr4q/C0MoWj7bLb9e7wkUNdetlrlZREq2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+xjoOv1NUS2+NnCZ947qIOUWLakEDCS2vmzrvlGO/U=;
 b=bwZYim++4dhzUhuZNDup2e8Wva5Z0+1tBloSDPB663Y6N0ipN8Jxf9z9DBCMzkyN8h2K+HBgG8DV4pF1audiHAr5sB7QFJT9hZLQLs59ydSXgVKS3Fq/q/I4d5dmIjjxtA+Ck/j7LDEDSDYbNufKAvrBSj4I0jgNyDlmmBL07WE=
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d) by BY5PR10MB4164.namprd10.prod.outlook.com
 (2603:10b6:a03:210::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 14 May
 2025 23:00:13 +0000
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::f77e:d409:2c52:ecd]) by DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::f77e:d409:2c52:ecd%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 23:00:13 +0000
Message-ID: <aaa73852-1bb7-43e8-9183-2b0dd36fbd45@oracle.com>
Date: Wed, 14 May 2025 16:00:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
To: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org
Cc: eperezma@redhat.com, peterx@redhat.com, mst@redhat.com,
 jasowang@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com,
 leiyang@redhat.com, parav@mellanox.com, sgarzare@redhat.com,
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250507184647.15580-1-jonah.palmer@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0048.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::25) To DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF18D5A7206:EE_|BY5PR10MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f4777a-46cf-4b59-9aee-08dd933b154f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0xXZFdxSUhKTUlIS2U5aUt5ZTk0Yzc0REZWTk16Q1lFeDlCeHZQL3pvLzBP?=
 =?utf-8?B?RzRsTlFIVDlxSGpkaDNtME9ld3pIRVJMZGZZVnRRWW1kdVF6N25aZ29OQkM3?=
 =?utf-8?B?bVV1SWk5QXM2dS9xM28yZXV2TngwOEYwWVpFOFo2ZHRNcVlCQUhBOGV0V3VR?=
 =?utf-8?B?LzdBMHh3MElrNGdHb3lEY1RhUWtDMlhRU1Y0dnJoZmdkYnlIVDV4azNDTHpi?=
 =?utf-8?B?TjYvdXBYeGxSdkZ3T3ZLdmppNndrRkNhVS93UlhMTUNkVnovYzJJNkdXemE2?=
 =?utf-8?B?Tit2V1h5aHRiWWQyZ1NhVmxoc1g1Q0lOWWxQRkJMOUdPSWd4dmRNWUI5ditM?=
 =?utf-8?B?bC9CbTlXemNYT0VLczJ2L0cyWUtkNnpLUDlVUnNsWWlxVVBpcms4NnJqSE5v?=
 =?utf-8?B?MTNQQ3o0OE43SWdiN2pnWFhGUGNjSmVadWJRRm42M24weGl2cU1NZm92cSth?=
 =?utf-8?B?ZlNSU0tmYVhJd2FUOHRFb0t6czg2ME1VZDIvYWtlOVVDV1lpVzBJbDN6Lzdr?=
 =?utf-8?B?eHc2anRFd09mZkdSSzVUNjVpdHI2UkY3UW1vczI2Ynhhbk9TYWlEZGZiUU5V?=
 =?utf-8?B?VDRvYlhHQVZPWmo0cUZCZ2RRS0w1STk2VzYyVW4xaUQ1L3M3d0gxckIzbnJj?=
 =?utf-8?B?dFV2UGRBNFBjbFFRV2JtN3FjcjRZY1NuYjFDVHdBS21kWjBsU3VmMUdCQkpZ?=
 =?utf-8?B?RzNqRXFkTm5CTFNTaVB6OWRUaUs2cmNncmxDR1FTU2tFVDVGdDZNajZpSkVP?=
 =?utf-8?B?ejhsQ1ljZzNWTFdrTHJUQzVrc2YwUlYvRklvcmYxM3lzeVh3TmplRmt1em9l?=
 =?utf-8?B?Rm05YU1zRmhWanZNWUlETmRia1lFbzJYbHRLcUtlckR3dm5ONm8yNWF1M05r?=
 =?utf-8?B?WUZMUkRCQUw0TkdlcEVaWEFOQTZuVjdDTk1vcmdEZkRGMzQxQVVZTG00U0Vh?=
 =?utf-8?B?UXpRTXk1N2hTL1NnSW5neFFhMXM5TUhkUmJCVmFSV1VPTmtMOGxvbGgwTSs2?=
 =?utf-8?B?bXZKVDA1K0hCUnBRTFRsSlovandoNG96S1RxbDFnMVVXN0lVdThtNVQwdjhm?=
 =?utf-8?B?aEJFOVZjUUF3bTdZNGJxbERtdTJ1RE1rN21nNzhxczdYNHphcFIwck9GT0FF?=
 =?utf-8?B?aFhWdVJvTi9hSkU1Q3FjV0hWRy9wTG9rMXpqVEVEWVBJQTUySlA3UDJpZHNO?=
 =?utf-8?B?MVhqWHk5QUVxVFRpN2ZJMDhjS1pzTDRzYzJNOUxJcjdDNlZFVDN2Wnc3QmhM?=
 =?utf-8?B?TlBKdXNkVEQydGgxRlcxKzBFNWdwalBGUkhEdFdsY1E5QTdXWmRzRjVBc0dG?=
 =?utf-8?B?Q0FuTGZqbTZ3VW8rWmpnRWVyRHBwOTNvUVB0eWc2ZW1BZlA4REtXdnZ0UUV0?=
 =?utf-8?B?UXE5T2JJNzZNbDhOay93ZStwWkRjdUx4MkQyNGdySkFZUG5zMnVSK0FvaW9B?=
 =?utf-8?B?dTQxb0w2TEtJZU4xTkhXMTVEYktZbzdSdmNLUng4ZzV5bkEyTnM0Ui9uNWdT?=
 =?utf-8?B?Rjlwd2liVnNlZk9oVWRFc290cFdPV3J3a2dNL1E5bHVWVWg2eTUzaUk2alpV?=
 =?utf-8?B?SGwrd1Y4R1VIQzZOWndMbHlQZTFvZnZUTUJtYkIyTDhYeExnN2tUYlQ5Vm9X?=
 =?utf-8?B?RUl2cmhZZnpKZDNxMnJZMU1wOUNOMXZaSWpMR3JZTlhlK0o0ckIrS0ROS2FZ?=
 =?utf-8?B?UTBpYWh6RGE2RnZJNFRBM1IxdlBES1hLUzRablh2ait0YXBFajBuRjU1K3l1?=
 =?utf-8?B?N3dTL0M4UDMrSU1RV21acTJFV1lZK01rZFFsS0R4TXE1NWoydmo5ZXpBYlZa?=
 =?utf-8?B?bGd0bVJ1b2Y5WEoybENva25MSkE1eU9OeGpaNmVmazBUTjFZVzczcnpIK3g2?=
 =?utf-8?Q?pXHucOQ0u7ZLE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF18D5A7206.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDRZcDg5YmxkSS81WUtWN2ZtS1Y4TkgzM1ljN2s4U0dtY3BaVzRqODRreGFp?=
 =?utf-8?B?ZVg3dnRDTXdsTk43Rnh0VzRuUmFkcDV3WkV3ZUZDYVY2S2dGOE95eHg3V3Y1?=
 =?utf-8?B?bmRSdU9qZFBkaFVLWldLWHdZbDdacmJTZGRXTlZ3QXRtOWhSczB6alptblQr?=
 =?utf-8?B?YWZLVlk3MEpENFBFQjY0ZHA3R2JiNHNleGNtQ2hFZ2ZmZ2RTOTdHdWE0ODk0?=
 =?utf-8?B?UUpaRGxjSzdWUnFveTY2L3AwVkwybmlmbWtEcDVLUnVPQ2NDQ3orMWV6ZHps?=
 =?utf-8?B?bnBsSzg5MDVieVZqR0tucE1TeWZ2MzZjeGVRNUtoSVhLaGRnck8rdXMxdlBR?=
 =?utf-8?B?aHJma1FiK1h1eGYzYXpmeVhwSXM3QzdrOGxWWVRsS2JERTZGbUhQUjNFLzJX?=
 =?utf-8?B?THcweGN1R2puVlFsUUkwUXl6S08rWGxhSkF4RHZSRmZCV0R6Y3hLYjRkU3Z0?=
 =?utf-8?B?ak5rNmV6NmpoN2JPYVhwSEw4VHBSQVNxUXI4UHQxOVlndTlXSTJOelh1MFl3?=
 =?utf-8?B?RndUY25LWVVCL2xWd0EvQ0V1c0lMeWZadlpPR0JOOTYwbUUzYllZZWlyTFpn?=
 =?utf-8?B?dmg2bjRjR0Qyam1tbklOend1S2o5TjQ3UDJCQktkd1ZPeHYxaG1Na2pqV0Z4?=
 =?utf-8?B?dy93dzVFQ2pscERsNVY5VUdzZDN2azgxRjU1YWZQN05NNStEWTJyYkkzVitS?=
 =?utf-8?B?bS8wR2pwQUdoOVowZHg2VjI4MUhPb0ZsRTlDZFRZODczV3E0MjZBN3dRTFBS?=
 =?utf-8?B?QWlCZ2I0K2VVQ0E5TDVOYnlSb3V0b3J2aW9PblhpVllwMXl5Z2lOdnJ0c3pH?=
 =?utf-8?B?SWgweUM4VXFqbkhYWDh6emI0bVlTdHdwQjFMSlFXSU1GWEhta1d6N3c4UFlR?=
 =?utf-8?B?NWw3TTEzQmVKQ2graldwM1dVWnQ0eTNkZWNIUnU3UVV0ZUM2a01XTEtiSjhh?=
 =?utf-8?B?Z0F0RHhJVUxPZm5HbXpZazM3Q204QkNKRFA5TU5KMzVRY1FLMXMvRk9UT2FU?=
 =?utf-8?B?Z0h2OCtGTlFNaUROTVp2dHdWcnhXc1paWWo0WWZsL1F0QytibHpRSWJmWUpS?=
 =?utf-8?B?RlYwejF3QkpITnVRMENLdGNkeXlSQVZUT2wwVXQzMG9Qd3pYZjc0ZFlpMVhM?=
 =?utf-8?B?NHNmd3RJN3VUeWh3dmdleWdRWlcrWGZUUDdvVk5tVmNvcG8wemEvYmpOWFlG?=
 =?utf-8?B?SGJXSEpyNFFqRHIzSk1RZkk4VXNwYkx6Ym9KcXFYdkZWdzBVdHk5VlBSRGRj?=
 =?utf-8?B?Y1V3REU3MlA2ODliaWdib1BGUkEzVVVrZG5MT0RjTVRiYVNWWTZtUy91YnEz?=
 =?utf-8?B?RmdtcGFDblBoL1R1RFBjc2tzOUF4Nm1xSVNVSVhkVFVNRzlsclNXSXk5bFZq?=
 =?utf-8?B?YU5jZDNWb1BRNGlUN0RLYVRWVDV3Z1ZTSWVoYmwrVFJDb3FqODJVR0RpVDlw?=
 =?utf-8?B?NmpkdmlOMTFOR2xlMWQwNWpUbkhFc3lUYjQ2aW96YVE1N2V4b1Z6aitaUzZu?=
 =?utf-8?B?RXl0cjJha0ZYVGVJRUNaZHJDem1iTmtpeTdVWUJia3JtVjF3TWhjbXZXczBX?=
 =?utf-8?B?UjN6OXNraVVUa3Eyb2J4dEl5RmIyMGtxYzhjZHhPZk9BU2FIbUt1UkZDbjJ5?=
 =?utf-8?B?L2MvQllSSFpRRUtkTWdsRlcrSVJaV2l1ZDV3KzZhTFVwalhZTjZGMHZ1NDha?=
 =?utf-8?B?cjdvbDIwdlMxbWd4U0F5eFhuWDZoSzBuU2JwZzBHbHhLaTRINzk5a1g4MjlK?=
 =?utf-8?B?ZmZGNVdqZ1lleklReWN6V3dvRDV0blBaU2xhWnFTUDhuYnlmZlVTdXhtNnBq?=
 =?utf-8?B?b1duL3hXNUkyWEpyRWl4MWZubldaY1RlUjZtaUxNM01ZUlpzNGpHRXBUMVdF?=
 =?utf-8?B?VGFNY0RiY1NXVHJBcHdJNSthc1lFcktxckRnbHBubXNkSm52eWFSQzhZSDE2?=
 =?utf-8?B?bzNESWlYd2ZMM0JsaUNlOGxwSTFJcjdPZGFwMEs5RU9hbXpBb1FQOE9FMXd6?=
 =?utf-8?B?enZxak5KOVJyQlA5dTlIcmZGTFc5TXd1bGZSUlZtTTNKbmt4QzZML0lSVjVF?=
 =?utf-8?B?TW5HUWZCUWxYSFNJWTBtNGg5RDNud0t0UjlIUENjOW5pekY3cjhKRmd0ZUhC?=
 =?utf-8?Q?OKckR5zdxL7joEhtNUwD+evEO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PSa6Xlp+Yyrv0Wdn3avlyp/5LKo/VZK0PTRuML2zj7JBgPP8e2hUAm6o6CbOh6KcXwo72yZ/etUMZdIAZrHqHEEBocEKHx5zvQEicDlRZtCJmrZVdcxLa0pVSFlSqAXO80UpQEcCc1xpWxSUjmQWWjEo7QDadusYhM+L0yo38H1YF2uO29h94+G8l8PBdFJOUwNVog4Qat04+NSK/ty5IegenWui/4CUTVzVOvOXm7US1owVcP/ZFdWYrIq+GIOCSWH3AiNGMHuqairlck6GYULvmcQSb88qpvZzuqM6npxwcK61qJE7Lxjl3o7EDAXCZ1BF5yiYCI7ds1EpuzWDsNnXPiLv+viLjbpdJiONhroeV82BC/PrkIe0nYmREVMYLPpDYycL3zme5fNqby5ovsSfYbDubF41/OJYFraz/vIBslLLXqWRn4mQ2z4g8293qS6ElbMKKhVNDxvVd0UR4AQcHVboJ4q7Dhj2X5j7M6/DDF+xf1TSQ2JHIS5CYBbK8DtA6B9uG64k+YEPF886WyO7CqgX9t2I5hZPTB5l8+0pP7xQIep4R7ksDu3f5LfgJoW/MpysKJxMfxrFoyXNySel9skqQGuxlol3Z95Ofjg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f4777a-46cf-4b59-9aee-08dd933b154f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF18D5A7206.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 23:00:12.9226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGwo61ixh4bewBA2fv2zY0D7YXgqyUGxI69RuckmymWhNq2EHBGpak64sBaQr2/4SXQUJD6qu37yERLXOMqy5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505140213
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDIxMiBTYWx0ZWRfX1OEk298jwWvL
 imuofLxZH+Xg7JamNROqxuWG5ouzn9xESWECZAcl9tjAt+JSqKarqjaNevlsJ9DSJdzSzfoVD4B
 x0JJDQD1I7/MywFu4jBQAgxmpBipUMy5yvRSrxW3X1YePtrTvgsf+3ZC0v8Hs8IVc0a3r54jhqI
 GlCIjeaLGDCmANG18eLEzRiVjabDfPRfHLlhGxUxfFjyHkzfVAg761LdTyUkp/J5qcw83L9NlQv
 jogMtWqeeCrSlHyXZgIhNgyf9r1WUt28Pow/YJcfPFixmhdyVvgSgoeuVh0b9CJA8D11wPibmOE
 w9oyJCqp5fU+UO7CoxFP2LZdCsyRG3hKs5sdkiO2AndzTHwP4pxCabcA0G9qNSia/r36ks+QaDk
 BZgODDQaPYD2c9sBCPpQZ+c/+EVGn3aBg655CTGkEMRUzKBQapFeThe8MzKirYPOeOJ4jnBO
X-Proofpoint-ORIG-GUID: LSI3KZjYkl6pOFO6n972jCE8KAWrRERS
X-Proofpoint-GUID: LSI3KZjYkl6pOFO6n972jCE8KAWrRERS
X-Authority-Analysis: v=2.4 cv=P846hjAu c=1 sm=1 tr=0 ts=68252082 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=mDV3o1hIAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=9XO0XGxlSt1xFkQOF1UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=5WABlXvFAscA:10 a=n0c7R5xxTHgA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

For the series:

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>

On 5/7/2025 11:46 AM, Jonah Palmer wrote:
> Current memory operations like pinning may take a lot of time at the
> destination.  Currently they are done after the source of the migration is
> stopped, and before the workload is resumed at the destination.  This is a
> period where neigher traffic can flow, nor the VM workload can continue
> (downtime).
>
> We can do better as we know the memory layout of the guest RAM at the
> destination from the moment that all devices are initializaed.  So
> moving that operation allows QEMU to communicate the kernel the maps
> while the workload is still running in the source, so Linux can start
> mapping them.
>
> As a small drawback, there is a time in the initialization where QEMU
> cannot respond to QMP etc.  By some testing, this time is about
> 0.2seconds.  This may be further reduced (or increased) depending on the
> vdpa driver and the platform hardware, and it is dominated by the cost
> of memory pinning.
>
> This matches the time that we move out of the called downtime window.
> The downtime is measured as checking the trace timestamp from the moment
> the source suspend the device to the moment the destination starts the
> eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
> secs to 2.0949.
>
> Future directions on top of this series may include to move more things ahead
> of the migration time, like set DRIVER_OK or perform actual iterative migration
> of virtio-net devices.
>
> Comments are welcome.
>
> This series is a different approach of series [1]. As the title does not
> reflect the changes anymore, please refer to the previous one to know the
> series history.
>
> This series is based on [2], it must be applied after it.
>
> [Jonah Palmer]
> This series was rebased after [3] was pulled in, as [3] was a prerequisite
> fix for this series.
>
> v4:
> ---
> * Add memory listener unregistration to vhost_vdpa_reset_device.
> * Remove memory listener unregistration from vhost_vdpa_reset_status.
>
> v3:
> ---
> * Rebase
>
> v2:
> ---
> * Move the memory listener registration to vhost_vdpa_set_owner function.
> * Move the iova_tree allocation to net_vhost_vdpa_init.
>
> v1 at https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.html.
>
> [1] https://patchwork.kernel.org/project/qemu-devel/cover/20231215172830.2540987-1-eperezma@redhat.com/
> [2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.html
> [3] https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jonah.palmer@oracle.com/
>
> Jonah - note: I'll be on vacation from May 10-19. Will respond to
>                comments when I return.
>
> Eugenio Pérez (7):
>    vdpa: check for iova tree initialized at net_client_start
>    vdpa: reorder vhost_vdpa_set_backend_cap
>    vdpa: set backend capabilities at vhost_vdpa_init
>    vdpa: add listener_registered
>    vdpa: reorder listener assignment
>    vdpa: move iova_tree allocation to net_vhost_vdpa_init
>    vdpa: move memory listener register to vhost_vdpa_init
>
>   hw/virtio/vhost-vdpa.c         | 107 +++++++++++++++++++++------------
>   include/hw/virtio/vhost-vdpa.h |  22 ++++++-
>   net/vhost-vdpa.c               |  34 +----------
>   3 files changed, 93 insertions(+), 70 deletions(-)
>


