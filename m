Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B811FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHS50-0002zx-RK; Mon, 27 Apr 2026 15:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wHS4e-0002zV-Ow
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:56:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wHS4Z-0002gT-Ne
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:56:54 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63REMlWX1105367; Mon, 27 Apr 2026 19:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=eour7iYD2L72ygPkww
 iH0ohTrbLec/Vlol+wW2hfK1E=; b=LlH/Ig4vufS7yKb/KIucnn2awZtPsVOPKs
 HfkCqebvBZwMymOGPPbM18zEmdtJgcU0nCIsqZZYjvs3LXI9B13CqKrCXZHsOd0h
 lI2VT5m2lkYbDq1S0F5e/N1ZLLy2hoxc25SwGxj/VJgrnyrl6SwcxMlE3ywgUN9D
 E7Hvu/MPcoevBUeB1qPWLB15kHl7M0h+Imt40IxPOadc2UHiJSEm49R42EgDDg3S
 /QbngpyxRU+KXauCOg6Bppx6/bZDxtYTVE6mhK1N5PkZvHt7fZRvvNeEJVtU6ZIx
 CMKUBTBITMXwhZoH29JIxV/YLj1WnzrHGUgUusNbQnWmR3CHOknw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4drng8c26n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2026 19:56:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 63RJuKms006447; Mon, 27 Apr 2026 19:56:46 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011038.outbound.protection.outlook.com
 [40.93.194.38])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4drm2hqae1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2026 19:56:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xs5/zhR2OdS4wVfWPY711PS9KEVMqwnFfGqne7jE2nt+CmDKj6GW8nk+eCCk90xhC4y/tOyBCcsFb61hi0XhLqNSjki/3V/Bgz79ZWwDYoRzZxN3wRLxj0Rsa9cW+V/8qFQL+sEaCZJR0PyKAJPFBAQlK0x0h/o9kW99LiPIEscstqyAMSCBxPDWi8Z8tPaWmzVKKNFH9hT2NA5uxwBRGUOVuZSTZfYvdxja63PnZhLz/ZGNZktBgMkK7I94auxtzHG3rQzfii8QIXG91Ed8eXQkK9UiUkp6qPPECpY5YG4HpWEvE2cCKbcB2lF+zIlk8y2makHCo040Rt8KtSKCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eour7iYD2L72ygPkwwiH0ohTrbLec/Vlol+wW2hfK1E=;
 b=KdJv9rPCQcxear/aLuemSJa4J4XMMp+sD/ipecjILDDIORzhesIzK85gqIWl6q854+hm8xf6rBpawKuIfsPgfu/J2KQGvLFI/24yZWhcb2QDJ9p+dzcZPcgPfE6TQ7vOU6DGP/wmkd/XK9jK1T65wDp7EaWN24YqmO83l/k1d+bAPDcg6ntVRUXmlWdaAfF0pvlfW6JNY9xxT5Zv/WI4C6FyTzq0liTdttrEg+3qmWkTOmnyaUbzvOhMMhu8s2l3zmQpLQxgxz92Lhf/4JKxrRf93qZoTMcWsaxiCD+K9S/PtjDAhdpHZEgwtYutvIcdGLZPxU8hDj+A5asdtROGUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eour7iYD2L72ygPkwwiH0ohTrbLec/Vlol+wW2hfK1E=;
 b=lhuikpOmup56HUvIbCyW0I98CfX9dr+ajjArgWCMzbfZHy6T1gCVbAGjDvMXPDe8Dn9d/OGBcwCFvL37mmOI8oXZSHDxHiYwr/D5csWi1BvbI12VIUNU4wyAaKVn/e0SVnS+J58pyjaoxtWUcYfZvx9YmBM6+eRqNvJ2U6L6ULQ=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by SJ5PPFA7DBF91DC.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7c1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 19:56:40 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%3]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 19:56:40 +0000
Content-Type: multipart/alternative;
 boundary="------------AKirhnDZKu2uVBEBYRGHgyob"
Message-ID: <3358ed92-143c-4e24-aa39-ddab4bcb00eb@oracle.com>
Date: Mon, 27 Apr 2026 15:56:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qdev: test if DeviceListener is in use
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20260427162700.89750-1-jag.raman@oracle.com>
 <CAFEAcA-mJdZWWGRhFteoFiEJ=v_F=7UEH5NB9O5W9KPqQRkzTg@mail.gmail.com>
Content-Language: en-US
From: Jagannathan Raman <jag.raman@oracle.com>
In-Reply-To: <CAFEAcA-mJdZWWGRhFteoFiEJ=v_F=7UEH5NB9O5W9KPqQRkzTg@mail.gmail.com>
X-ClientProxiedBy: DM6PR07CA0112.namprd07.prod.outlook.com
 (2603:10b6:5:330::27) To IA4PR10MB8301.namprd10.prod.outlook.com
 (2603:10b6:208:55e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8301:EE_|SJ5PPFA7DBF91DC:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8b72cd-ea62-4378-cbd4-08dea49718e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007|8096899003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0Eo8lLVps9sHV92hq1xkk6A9TISwSh4lbwoGw3nx3FU88eUsZYNousdDaYpwvpwYtiiGZuolX0bZ4HCWJ/ObsfbB9IsqIsM7n8KDMR6BjWxpYbVjHylZUceEaHo4c67TCRHG/DTQ5fVNpqk0pVoxnt9lSQDatDhZUhuHEMBeF8mX/iNWrK0k70QPwPfxFkdj6e69fMghpVm8uK12Pf01K/SMwDiRW6SWM8J0eRVOA4mqOFiMP6g6z3A8w7eqcOh5a3wf8B4dHXImNkU17M0dt05e7WYaFFeCR3gvlMaw5Hglqv6ggt9DsoDsghCuwmDP7jXeupJbHiqQXaUNEMMXABHNrqyBv/IGYRnmyPg8EEpSBlzBLe3o8KDZqxdzUcZbySYo/Kh6gvO1aXU+kfxhJlRZo7p+eu+x6oEXNDVUAd/yVq7hQjrM4CUzUvLvyMYEt+ImhqTtiGrxZ574zEFRsColMsqpF5paZCZx63uEwrvrDl9+nY3Y3N6ffnUMbf1TUQ3uMP9Ik0oKUy46je+1EoXYPoWGTec6h11FNhuGNibrl4CWPFdzMER7SelYOXQZxaDyvyMjgNV7cT242kG1acsbVlEhMPssnnwAVVTHIOYBhu0LCveDtZXqklTy+an9BjbRtqr7qOxGbc4t73d3kx6eIYVa+9Hc5sdFLr6GZpdsq+zMyGiu6/sKeCnu8s4N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(8096899003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2doQjV5SGJpSHltTmpuSWlTeFc3dmcrUVZQd1B2TlQwRjMwZUI0N09QQTBE?=
 =?utf-8?B?YUZyWnZCNy91RW40U3BkdVQ2NFF6SS81OXdNY2twSFVZbk4vRUZnd080c3NL?=
 =?utf-8?B?RVpCM0tBU1NJTk12amxlVkpXZUExczRSUzVNQlNpYi84dEZSblBIRW94NnJz?=
 =?utf-8?B?TnhnTG9LSW5uN0orTzI2eTRsMnd4L3lHeTRzNjNLTG84WkpJTURDY1FwbStM?=
 =?utf-8?B?clY1dUtoblZnYXVYWGZ0Nkx3L3pmNkRsY2hMOGRxa0ZBQjliUi9BS0p4eG90?=
 =?utf-8?B?MUFFUERlYlVQUmRLdHN4SUE1QnNVb3RGVFhRWGxjenladUVVcTE0UGVHYS9O?=
 =?utf-8?B?eVU5dDlXdW94Y1B0QUdGL2RMTnRPVU5hYjFWb2lPNHNSMEpDQnoxWnJTMjEy?=
 =?utf-8?B?R0JjcFdxTHlBSUNrdlUwRnVRNkJKcHB4ZHBZcVFTTGlxZCs2aTd2MzE5NXps?=
 =?utf-8?B?em9KSWpvK1Fwb1NiN0pYQVMxdE95UGJUK3NHckRXQmxZU0VwY201TDBzbDNU?=
 =?utf-8?B?VXVNN0duYjNCREJIZS9jT2dON01HWEdweUdMY0lmQUdlcHZFZXFyaEZZQlNN?=
 =?utf-8?B?QWhUQmJFRVgvWXhjbWc2NjJZbzlQdEVzMmJwVFRwVjNhVTRDL1FWbnU2MGdh?=
 =?utf-8?B?WlNnb25XR1MyRTlNanMvVjNscjFFWklSZWhFTDdEQk9vUnJhVk5Pc014UlpW?=
 =?utf-8?B?cmxLTTJlMHNPQmRUMlQyc2ZFbjAzMkpLNlJQTkUrRFFkaWVBYzNsdDVrRDNu?=
 =?utf-8?B?WDY0cllDTmlMeG9BTVp3MXBYbGhON3VYN29JNVV6RDlkMm9UTWw1TE93NWth?=
 =?utf-8?B?QWFLemZoTkl3UzR2elFsczRENXhUV09PT05lcTkwenUrTi9iaHNSSzd0enNY?=
 =?utf-8?B?MXhReEloMWc1bkc5dEhnM3FJZFQwbExlSmIxN2pCeXFpay9CSHYyQUthSjVB?=
 =?utf-8?B?cTJnTTY2NXA0cnAvOGl3N1lOTnBGM2JrcUZ5ZVN6SE5GOEx1cWVSdXVEUDFu?=
 =?utf-8?B?SVJ6aE9mT3NKZmJQcEFzcTNKclBVU2s1TWg1Y2ltSDJiV3pJQVUzcHR6SmlM?=
 =?utf-8?B?Ry9Dd1BGTmFoaURtdlQ1ZkJ0dVJwR3R6eEhFUXB3cnVrM1Q5N2VsbmU0cnQz?=
 =?utf-8?B?TTB6SndvUitaR1NsTVlqNjA4SklQU05aOUtNQVpNc05HNHpUMzFmeE9PTWxB?=
 =?utf-8?B?SjBFQXlIM01BZ0xqUGhrUkdVV1RDR2lzVENxUi9rU1FCOGNJTWkrcVR1ZkJJ?=
 =?utf-8?B?RVhQZytSRXo4MTdSMEpYQU9yVVZOSWlBSGFHdnI3L25MZkZadnBDUTIwYTM1?=
 =?utf-8?B?d2NXazJWOExsVWIvR1RYSnJBcStpVkpkY2tHMzZzSCtjUEpNVGY2ZndwbUY3?=
 =?utf-8?B?T2ZqUTRQRHFYM3dQVXI2akpxd3NIc2MyMkJ4MHBVdXozeE9rRTZPU1pHZW5Y?=
 =?utf-8?B?UXpPaEtLYnk3S1Nsa2pIL2dCdmhuSEFYaFhlNDkyMk5oNkxLTEdmRzRZeG5l?=
 =?utf-8?B?a2xPY29XYWpJaS9WYUVDYkV4c3JzT2JKMm1waU16bkJjZSt2djJ1ODFkL21S?=
 =?utf-8?B?Z3FyV3Q2Nllac3Z2aHdLWjhzYlhtS0dXR0xBQlNjdmlxNGlUbnoyRGNTL0Nl?=
 =?utf-8?B?ZUxjMnJNZzNpYUlBYlpzdXZrVXVFUUlOR2ZvZ3lGYXM1WHdJWWJoSkZMcGx1?=
 =?utf-8?B?UTFyRWlMMktZVXZRZVJoaXBIU2RvZjlNNUZqZ1NEN1orZ3p6RXY3TTdYa1N4?=
 =?utf-8?B?WHRRSW90VTdaKzBPUGEzbnhaY1FJVzkzS284R2tOVzJGK0txRkF5VkJEYWVM?=
 =?utf-8?B?SDdsSUQ4TWdyRnJxK2doaGFHOGlFa1FxRjJISndtZ2xkR0Y2ZUdLUlBHc1hC?=
 =?utf-8?B?a1RWOXJuRXFHVGQ5VStUaDF4YS8welZIUmhwczVWZWNUVWFDdUJid0RNOXd3?=
 =?utf-8?B?K290WHV2bW5jV0t6dkZ2VlJTQzhvRzI4MzNVMjdjRjJDbkIwTklnZ0JadGpn?=
 =?utf-8?B?RVNLYUxyZDNXZmZlQXpVcXR5TUJMSFlPekREWHR3SkZHZDZ6alBGN3VROXRN?=
 =?utf-8?B?MlJLaWNoam5oT2RIWlFwVDlaelE0V1Z2V3FDNlZqTG03ckd5K2pNcWp4Yi84?=
 =?utf-8?B?OTlHNTZkWllNVUt3Z2pkMTlOZTVpVStodlZWQWNUcCtER1JYbTJua3NwZTEr?=
 =?utf-8?B?MDdnYUJob0JrelRZZGdGc3E2YVhRTU91cldxdVY2SWNiM1F5NmVjdzl5RW9Z?=
 =?utf-8?B?aGM1OXhiV05BTXVrdE9FcjdxYTdsY01zcjlnVGFtT0YxUEtXczNHbU9LTU9O?=
 =?utf-8?B?QUM1b2oyaHB1UXIyYmVrQUtRZG96ZU5nR3dBcWc0TzVBbWM4Y0phQT09?=
X-Exchange-RoutingPolicyChecked: Ibu1wl0/tiYtj1+iWWF4Zs1fN1b/mhOl7KDC/yROiMqKOVeaW5sTj8bhV/9SXJwTIbJfGpEYWI245kX62aIrXPEuP0FnOW6aLUZy+s5u0Z8HED2KcUm6PkPbN2bkmNt2ADVAsv0uv4T3yAk3omWVUVC4f8cyFBE5MzgIGIjXz4ryYiNMsHF1VBWZpfo/04kp6TvEEzHxhFsMpSyI3qDEPjyB+XqfV08r9H3Z20O2GiJpMs+FmqDZJjgNzmnV8H/VyiIKUGLa3P9wLo9qPajnqWjkcLwBC26z87a9Cx86kC4+T2EF4LQDYPjx3siQjuVDbEEqMocU0+Z2+QmgiihMnQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mXOR3p/BQcuk+eVzEKDtFtuLf8i4ltSS+1JveFmZAxiyzPNax+Zwf1r6tyl617IMvJLKsgYwTVuHWrfyIutu32wg8OIXP8ihxCt14BGdFUlYTiXNSBEEAE5Q3bh9aMhT1uuqstJNbNsQAR0/QiCAQCyOAuKNE8/UfPZf0Nus13Kg4uxzRaLS5e6S48rRlxFXSM9yNOR0iRqfdDROikBo3oY7qMY6le81yLPwujAJJZas1IopO37u37dYJNTbCHC/jX+nihZpTXnUI0nZpZr6NX4LuF7trimiDtaj6DQ/sR1586zLjVLj6gt8vWecDFnvyo91Z7ICxvSorTQR5DpjT3lHFXwOeHakwyIbgZFblygrArKjMphS9Omw+kgoOifQSX9e/b+pyIJvOCObD/uevWROnt26GAtfiGZacUbyClaaIhgrQfxgF5K4BZrX1ZCVFUyn5PHFPFr9B4flh47rJtbUqEW+AGVyxvI+Q9qSdTj2HUPFZ3czc80TziD/Rl9OWRSx+LMLVf8tGvw+TQ6YmX2j+TwauDzLvv5MjISEUCKZ/p2dWpVCiZa814OS9tInj/vohCxBo4QlX3SXE060xk+k35vmuWcsb6CBfy9ZH44=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8b72cd-ea62-4378-cbd4-08dea49718e6
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 19:56:40.0538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjRs1W9UFpEvTcAMFP6RK9yQDfe2+ZS6GFJC2PtUp6YSVGo+b8FGiyX2Mf7JXGuWyTL2ebpNc6tC8lYrJMLX+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA7DBF91DC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 lowpriorityscore=0
 malwarescore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2604270212
X-Authority-Analysis: v=2.4 cv=U7uiy+ru c=1 sm=1 tr=0 ts=69efbf7f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=Vt2AcnKqAAAA:8 a=69wJf7TsAAAA:8 a=GaQpPoNlAAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=fM2eUnMG2cke1KWmL7EA:9 a=QEXdDO2ut3YA:10
 a=pGLkceISAAAA:8 a=zaGmh8dvhNm82kO35mUA:9 a=YnLs-0QbqAxoNljp:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=v10HlyRyNeVhbzM4Lqgd:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=xF5q_uoM5gZT5J3czcBi:22 cc=ntf awl=host:12309
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIxMiBTYWx0ZWRfX0wssBCexqDwC
 4T11FD0moyfZyMW70KVSwBy61KrciWFma73olrJSlbw0C/iQKo1WNOkgwuZBuvyl9uk9+qaqOt+
 fht9hZNqLAq65pLAM0e6QeBjrDvKmNKw9bJZ+iDqES0FDAlB3h7GqOu9zMW6OggOW6XBqJWJN0p
 F18l29UJ+61ekZWcSKlHMdj7rl0xXzZgHBfYGFzmCgHWBnY5z4ohGTD0/qAuhP0GvOhSEPK/JyM
 4s/xecQTJKxbH7tlbjjpA/z5TuolIn0yhay0Vhg6KJ/rfbL5V1rykbeky1fvfEJRHJkbEU2w8Aq
 gS0HMU87C98LpH6a1P3nP7VF9140KbdP8JZ65PLdhtOFPhpe2xy3NJ64WSpVmyyAjK/rJUpNAYC
 Lb+rqcEdWLUP7i5CxkxyzukA/AlA3szw5Jy9hE+6GsKMajmqnd67ioPikretPFRmQRhehm9ZrrP
 nR7O75A148xMeimpI/UgnHJeNcq16/JkqPIKzKRE=
X-Proofpoint-GUID: tWTwaV8yjTULdIMwTGjWXrZDGS5zwsGW
X-Proofpoint-ORIG-GUID: tWTwaV8yjTULdIMwTGjWXrZDGS5zwsGW
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--------------AKirhnDZKu2uVBEBYRGHgyob
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/27/26 3:48 PM, Peter Maydell wrote:
> On Mon, 27 Apr 2026 at 18:43, Jagannathan Raman<jag.raman@oracle.com> wrote:
>> Adds a function to test if a given DeviceListener object is in use. This
>> is necessary to confirm we're not unregistering an object that is not in
>> use, which results in a crash.
>>
>> Fixes a crash when we execute "qom-list-properties" QMP command on the
>> "x-remote-object":
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg1185472.html
>>
>> Signed-off-by: Jagannathan Raman<jag.raman@oracle.com>
>> ---
>>   hw/core/qdev.c         | 5 +++++
>>   hw/remote/remote-obj.c | 4 +++-
>>   include/hw/core/qdev.h | 1 +
>>   3 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index e48616b2c6..97b09f6e7f 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -208,6 +208,11 @@ void device_listener_unregister(DeviceListener *listener)
>>       QTAILQ_REMOVE(&device_listeners, listener, link);
>>   }
>>
>> +bool device_listener_is_registered(DeviceListener *listener)
>> +{
>> +       return QTAILQ_IN_USE(listener, link);
>> +}
> The approach used by memory_listener_register() and
> memory_listener_unregister() is that the latter is a
> no-op for a MemoryListener that's not currently
> registered (we test for listener->address_space is NULL,
> and at the end of unregister we set it to NULL). Would
> it be possible to follow the same API pattern for
> DeviceListener rather than introducing an is_registered
> function ?
Thanks, Peter! I believe sticking to the above pattern is better to remain
consistent with the existing MemoryListener implementation.

Marc-Andre just published a patch which does something 
similar:https://patchew.org/QEMU/20260427-qom-tests-v1-0-c413f3605311@redhat.com/20260427-qom-tests-v1-9-c413f3605311@redhat.com/

I'll follow up with him also.

Thanks,
Jag
>
> thanks
> -- PMM
--------------AKirhnDZKu2uVBEBYRGHgyob
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/27/26 3:48 PM, Peter Maydell
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAFEAcA-mJdZWWGRhFteoFiEJ=v_F=7UEH5NB9O5W9KPqQRkzTg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Mon, 27 Apr 2026 at 18:43, Jagannathan Raman <a class="moz-txt-link-rfc2396E" href="mailto:jag.raman@oracle.com">&lt;jag.raman@oracle.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Adds a function to test if a given DeviceListener object is in use. This
is necessary to confirm we're not unregistering an object that is not in
use, which results in a crash.

Fixes a crash when we execute &quot;qom-list-properties&quot; QMP command on the
&quot;x-remote-object&quot;:
<a class="moz-txt-link-freetext" href="https://www.mail-archive.com/qemu-devel@nongnu.org/msg1185472.html">https://www.mail-archive.com/qemu-devel@nongnu.org/msg1185472.html</a>

Signed-off-by: Jagannathan Raman <a class="moz-txt-link-rfc2396E" href="mailto:jag.raman@oracle.com">&lt;jag.raman@oracle.com&gt;</a>
---
 hw/core/qdev.c         | 5 +++++
 hw/remote/remote-obj.c | 4 +++-
 include/hw/core/qdev.h | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index e48616b2c6..97b09f6e7f 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -208,6 +208,11 @@ void device_listener_unregister(DeviceListener *listener)
     QTAILQ_REMOVE(&amp;device_listeners, listener, link);
 }

+bool device_listener_is_registered(DeviceListener *listener)
+{
+       return QTAILQ_IN_USE(listener, link);
+}
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The approach used by memory_listener_register() and
memory_listener_unregister() is that the latter is a
no-op for a MemoryListener that's not currently
registered (we test for listener-&gt;address_space is NULL,
and at the end of unregister we set it to NULL). Would
it be possible to follow the same API pattern for
DeviceListener rather than introducing an is_registered
function ?</pre>
    </blockquote>
    <div style="caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration-thickness: auto; text-decoration-style: solid; font-size: 11pt;">Thanks,
      Peter! I believe sticking to the above pattern is better to remain</div>
    <div style="caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration-thickness: auto; text-decoration-style: solid; font-size: 11pt;">consistent
      with the existing MemoryListener implementation.</div>
    <div style="caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration-thickness: auto; text-decoration-style: solid; direction: ltr; font-size: 11pt;"><br>
    </div>
    <div style="caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration-thickness: auto; text-decoration-style: solid; font-size: 11pt;">Marc-Andre
      just published a patch which does something similar:<span class="Apple-converted-space">&nbsp;</span><span style="color: rgb(0, 0, 0);"><a href="https://patchew.org/QEMU/20260427-qom-tests-v1-0-c413f3605311@redhat.com/20260427-qom-tests-v1-9-c413f3605311@redhat.com/" data-outlook-id="05ae7b83-100c-413b-a8df-3c0b8d2cbb96" class="moz-txt-link-freetext">https://patchew.org/QEMU/20260427-qom-tests-v1-0-c413f3605311@redhat.com/20260427-qom-tests-v1-9-c413f3605311@redhat.com/</a></span></div>
    <div style="caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration-thickness: auto; text-decoration-style: solid; direction: ltr; font-size: 11pt;"><br>
    </div>
    I'll follow up with him also.
    <div style="caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration-thickness: auto; text-decoration-style: solid; direction: ltr; font-size: 11pt;"><br>
    </div>
    <div style="caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration-thickness: auto; text-decoration-style: solid; direction: ltr; font-size: 11pt;">Thanks,</div>
    <div style="caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: none; text-decoration-thickness: auto; text-decoration-style: solid; direction: ltr; font-size: 11pt;">Jag</div>
    <blockquote type="cite" cite="mid:CAFEAcA-mJdZWWGRhFteoFiEJ=v_F=7UEH5NB9O5W9KPqQRkzTg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">

thanks
-- PMM
</pre>
    </blockquote>
  </body>
</html>

--------------AKirhnDZKu2uVBEBYRGHgyob--

