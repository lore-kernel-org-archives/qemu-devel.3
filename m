Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05282CCD190
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 21:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8mrJ-0001g3-Ax; Tue, 14 Oct 2025 17:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v8mrG-0001fh-Kr
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 17:47:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v8mrD-0002VE-BW
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 17:47:02 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEf6xb014385;
 Tue, 14 Oct 2025 21:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=OmnPTJDTLdKonksg+4LcKqTPzyWcPZhzPwK3rR049Aw=; b=
 LxpHlMFvYBjSel9h/DVQ5x5ZXT/wCQLCeZIn7tuiVd1CqkSi//99OHAlAWXKs1Ig
 ga7G1qaBxCudNg46cWZCWsX/la4C/Jz8JPYmnU0VFX3VgNR4DtuD+PnfofUO/GCM
 Up/pNNQdzeoCqWjauox6/a6JAh4wo8v90oHCipQRuS3/BVec2njbQZS1E0oFK7Ap
 f8IwxM+/zMDHDEref1KAPRRSAI7gJpMt41srwp6axHwynhtSwAeZ2zIOiaSPpv9b
 XatNMYBgerjI72b73VWP/71QkPFFqcjijuwozATT5n31MLxG5rZeP03KY/ExllCy
 puyCI6RF8Vszbm0vkTv6nA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ra1qcfq7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Oct 2025 21:46:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 59EK5Pqr026358; Tue, 14 Oct 2025 21:46:51 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49qdp999yb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Oct 2025 21:46:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2tboeYuSsvSs26Ecj22nsaJTalWAlaiO+wcCxHmQK5ryn4wyGleuKowq98eX96rVUoB+Gyjpc14RkgvJ8c6Uv1g9bWFln2bRzjbcrVTUujx8CbRFuFQyIPBl9skjQXtSUcTiDoojUUsQJQWZLXPDfbiu4i+XYI+Q1QY4b9tDd5+ppnqn2uBG2bJaIvcNhCIUY98xTAj2GcfNlnfmwDZuHm6fza/1QyHhtK1B+C2BCcKjymni7qHpSmb7KMnLlTrI1d3OmeZ41aZ3DXSQyIG9cGZEnWJY7bhrXOwSsX/Hbxs//pCFJQDfwbGxh6wQOiBr+6MO8T432FbAh+mvDh1Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmnPTJDTLdKonksg+4LcKqTPzyWcPZhzPwK3rR049Aw=;
 b=p+gzMfxE8m0CttmdhlVACK/7VUJsY+WnnOapMuzq8dZEYfJOJbTZgxl32LbhlD0Mmx++QRcEh60M+qfD/z+lQ8JOC2j6rszYFWf5lhkSg19U4oMt+hoTzwoHtDUQRU3WPvuCqN6lGGh748lyVHQoeUPx5rZfvhFLvyuA2mR/k9YCzFJPn9Xi6Xf8r4M1BG4oW9uPh9OvFC6x7CkRvVF57uC2kYeiQjeQIUg21OV8YRSFFY5TNfDYDJUjA6E0UZmGnsmEb971u9d2/I9NJuv8WkLo7N+KDSYbxF5ZfsU7CCgoqBbQZfcA+738WwtY90u7J2M/xA5I0H+hDs9IuX5hlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmnPTJDTLdKonksg+4LcKqTPzyWcPZhzPwK3rR049Aw=;
 b=c2np2u7F7rW5Cygi9WEOi9lnnCaUEkFjezo5w9sMMEpYpzV4QXHVSaZuAKYrQSman8sZC8husIDrfzU+dz/oFZRg7WpPAcHA6SDAAC7CtXaeAWjMQU3lWIJO89YPYdWoCy8MYzoq1/RWkW7DQznOGCub8DU/ZG3o9UKwCH7qFqM=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by MW4PR10MB6417.namprd10.prod.outlook.com (2603:10b6:303:1e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 21:46:45 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 21:46:45 +0000
Message-ID: <c585b4c2-5bde-4aff-a3b0-370bae5e9c0d@oracle.com>
Date: Tue, 14 Oct 2025 17:46:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] amd_iommu: Fix handling device on buses != 0
To: "Michael S. Tsirkin" <mst@redhat.com>, Sairaj Kodilkar <sarunkod@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 philmd@linaro.org, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, aik@amd.com
References: <20251013050046.393-1-sarunkod@amd.com>
 <20251013050046.393-2-sarunkod@amd.com>
 <20251013041059-mutt-send-email-mst@kernel.org>
 <6fa9b33c-31ff-43f6-8ab1-8d200c832c94@amd.com>
 <20251014050023-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20251014050023-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0062.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::14) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|MW4PR10MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: dec59e8e-5388-4462-1e2a-08de0b6b2b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEZ6YTkxTFNqaHgyK3lpL0JMZW9DZjY1dVM3bU1KejRmeTR6UGtlcHJFaS9I?=
 =?utf-8?B?MDFYUktoR3FFd3lFOE5makRNUzYwYkJDZHdCMzdmU0w2QS83SUx1REpGR3NX?=
 =?utf-8?B?RUh0aVZnVGljNHBtdVgycW9PbVBINjJ6TFZBQTZJRkptMzBQTFlObUxXSUNH?=
 =?utf-8?B?SnlrNkFBWS9qVGdZa1hvalEzSnpDYjFRNVVCUmkrZU41RFpuSHR1VFVPM3M2?=
 =?utf-8?B?QW8vNXRHTGExVm54RjhDQXFGaUJJaVM4bFlFdEhUY2F4L2RUS1c4SUVMU1dV?=
 =?utf-8?B?M1h1a3pZRjFxZUliYUZCMmRjVE9JOWtFNlcrSW83eUFsMG5ERXptbHBQaVFa?=
 =?utf-8?B?TTJzKzJaUVluMTZRbHpNVVY4ZXFMR1ZQSGtRNGNhWkdmbHRXZ1VRaFo5RUx4?=
 =?utf-8?B?YUw2enRJVUE4SmQrUlAvdTZSdUhZZEV1Nm1RMUY5N2VTb2lqb3lENW12eDBJ?=
 =?utf-8?B?UUg0bjNESnBlL2Z6NTlhK083TDNSMGx2aVNHNkRCdWNPSnFSM3hQdEtKaVBG?=
 =?utf-8?B?dnlROGV1STlod0RPOFNvTmt5b2pLMU1ldStNeEtreXYvVENDd1NiRTBrN1dx?=
 =?utf-8?B?MXhUajlYczVsS3dCWlRPV1FxbmZZQVZqZTVrRlZzOWR4ZWtQckYrdlc1VVdU?=
 =?utf-8?B?U2QwcEZvd1JMUnhyaEpBUS9uZVRIL0wranpqU2ZENXpvVDAzZVRLeHY4OW9T?=
 =?utf-8?B?VHppVjFhTjhUK3EvZlZqU0wvOVdYdXgrZ0krMUV2TWNNd0JMOXBhYkxlZ2tt?=
 =?utf-8?B?WVgvMTBKSVAvd0M1RGp6Qmw3QTZZUEVHQ1NkeVZER0ZiUW5CRHpLUThWK3R3?=
 =?utf-8?B?ZlJSS3BkbmJvempQUDI0ejAvV3pBcDVPS3pNbVVVa3hyVGFzb3JvaHRZK093?=
 =?utf-8?B?bGE1WHczNjlJekZNaFpqUFM2clRPS0NRdm1lTmJla0EzNE12Z2VZdHZWcGVx?=
 =?utf-8?B?MERCSmVmVzc1b0UxdHF2OUt5SGs2ZG8zMTkxSTBFaFVYTllMRk51aXhEaTRV?=
 =?utf-8?B?VFMzcWdyemFma3J2NWd5U2gyaHRjMmE0bzh2VXo5MFpPODZKYnFVbEVSNXY1?=
 =?utf-8?B?NkozUSsrY29BVmR1anBpZFpxQlZDQkE2ME9hOERMV2ZUaGFQU0VBMEs4cGV5?=
 =?utf-8?B?aWlSaFdocjNNS3o5SFdoYVFxd3phQzZmcitHQUw2NlpPMTFwc1Z4Ri9VU2xD?=
 =?utf-8?B?RTljVXBDZmxVVDJXOVJBWXhzM3NqSys4REdtZkthTFNKSHFxaTV4Sm1CUkJC?=
 =?utf-8?B?TjY3VlpaaDcwZG55UTE4Z0Ntc1Q5TmNvWENhYi9MWEV4cWNhUEF1Um16YlA5?=
 =?utf-8?B?b2xyN2dWUGErK3R3bmRJQUl6SDRiWHlIMWVsRVhRb0RZcDBzUC95dWhKL1hH?=
 =?utf-8?B?cEZCNlJSSEZZMHRyRENwUTR6RENsUm00dGpjOW02YWw2NmNIMXZUWkRQMlpT?=
 =?utf-8?B?NSt3UksrTFM4dFBXL0lCYXM3OUZRWitJcDVtSHlZRUJMNWdQQWI1M0xMODdy?=
 =?utf-8?B?aWI1ZTY0OU9BSzZwa2x1NXk5TC9PYTJUbWpPR3hWQ1VVMjhDZTd5alg5S3Js?=
 =?utf-8?B?akcwdW5rMGdjTEs3Yjl5RU1qN3I4NUtXOSs1S1lERHQ4czJ6RDhSQmtJMjZz?=
 =?utf-8?B?ek04TmZpZGNtNDdhZUd0SUdJWjc3ZDl0bmJDQ1g5U0VvTEoyTlFRLzJhRFJ1?=
 =?utf-8?B?WHRMUko0SE4ySkFpZmRMK2hqTGF2VnpFdDdPK09TeUpUVXhwZUhFVU5OWXdv?=
 =?utf-8?B?QU4yeUp0RCtYTXVzTW1VWWN2SCsrbU9NclRVbkpHTTZwVWYzOU02aVEyZU5B?=
 =?utf-8?B?RTE2aEV2b3o0N2R5WGd4cllhNEdMdHQvUWtrVFdCVXFTTnhjNEV6NmFZczkx?=
 =?utf-8?B?NGV0QlN4TWdRRkpaUUtYWHBZVnA4Y1hrd3hiVnp6TGpETkxtbzcvT1p1V1pG?=
 =?utf-8?Q?MEl949WkXBEehvncOzXYh+8si7L3Z4q4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sys0VWNpdUxMZ05RVUlQMHZZQ295bkQzY0dlY2c4enBCdEpZRGpJd0NaTDhB?=
 =?utf-8?B?bzZWdkVXbVFsc0VRRExHUXRva012V1F3OTRsRnZKSlFQNWFRR2dxWE8wRXdK?=
 =?utf-8?B?aUVzbDA5Ym8xcy9IV2RTamxZcWYzeUVHdkk4OGFXWFVVdU1TWjFhbVB0SUdM?=
 =?utf-8?B?c1dtaGhOZXBHL0NHaUUvakhvelFTZE9SVXQyRUl3amhuKzF4Q0FCTlhTQTdk?=
 =?utf-8?B?SnJVVFd2RmVRdkRMR0s5VzNNWHY3MlBKUFIwWXlpZmhiY2d6Mmc4c0ltb0lv?=
 =?utf-8?B?V3VPVWc4RmtWZlR4TUxBemZ0bkJhK1RBUWlaSXhhSnJ4UHFUNURMcXZLaXZO?=
 =?utf-8?B?WFMya0Vsb1NFUlpjcS9nTndRMmZSaUd3NEh2ajNIK090bmFJc1I5UFAwZkFn?=
 =?utf-8?B?NGRtb0JUT3BVVUs4ZXI2T2piTkFRMUl2TVpadVQrRHZOcFhVaEVOdzZWWnlW?=
 =?utf-8?B?QnhzRm5VWGZjRk8rMVExb1JLaVJJMW83Zi9QNG1XRjdyTmpMb09oaVpQRUND?=
 =?utf-8?B?VjZrOVFuTzFVODVERkxkSVZIdC9uOVV5RDBJTkUvZmFXc0F1UGRpbUl3RzMr?=
 =?utf-8?B?WE9JRi9MNStCM0dxeGR1aFF4YlNISlNMM3I5blhCbC9QcGVYb1pyY0k1bTZo?=
 =?utf-8?B?TWhVcVZvS1gxci9rVnFOc0NXbjlkMFoxeUV3YnRhSVZweXNMSklqeGRzZHpC?=
 =?utf-8?B?bVdQVWZuS01PVkpnWEtIQUsvMDZLcFN0RGFiUnlKcENpdHZFeVNIc3BONmpX?=
 =?utf-8?B?UVd2NnB4d3N1U3hoTnBNenhOQ25QcUxVNTJ5S3JtVml6VnZyMGd6bnFhQXN4?=
 =?utf-8?B?akJURzFOcGlRaE0vR1hSMzRkYmVseG1sYWNTZ20rRXRjVGVtVzBab2JYaUYy?=
 =?utf-8?B?VFRzVVFRNGtOUDhzOVgrNXhkQ00rNlZ6bFZFWWpSZjFib1JlQWVoNXZCb01O?=
 =?utf-8?B?ZWdacVA4aTlaRDREUjE2eGhTR3Q0dkpnVTZBWmRMb0NidjRkeDdnY3kvaXFn?=
 =?utf-8?B?ZnJOTWorZ00yRUJadDdwbUpFREltU1JmK0RBVGUvZ0dOUDNtYkdLcEx1Tlhm?=
 =?utf-8?B?YkNCbUVpaVZrN1hVRkpaYzFIajZmZkNPcStqZVRMK09iS1NYdHZwR0grREE0?=
 =?utf-8?B?cnNnaDNlbDFDblpjKzFmc0xsZk1mTWw5YWZzazRsbkgxdzdsSXJZa3Q0RzVV?=
 =?utf-8?B?V1NXR1JrMzNCRFgyeWUvbm5GTjNZMGE5dTRZMG1mNUU2Vjd2RUIrRVNKMFAz?=
 =?utf-8?B?OEJ5RmJWNTQxMzE5UC9tcS8xeFZadXZtRVF6dVllejUzZEcrNm1oRWZCanJ2?=
 =?utf-8?B?ZkZ3Y0hoeDNhUGVWNjR6OWY5bi8wZzNTQmIzUFhIM21aTlpEWXc4cm04bytS?=
 =?utf-8?B?anN1czFaYzNwMFpENUVxa0ZMNDNLVGxkTjhsQXN6dXJUakJocWxYRTJkU2hH?=
 =?utf-8?B?bDhxRFh0bEJUL1VySHpKdjR2bjZlUnRMWVlNYytrNFkwYmc1MDB2Y1pVaGF3?=
 =?utf-8?B?Q0JEeTZiNzlIcmg3T0NHcWYvdnZLa0paMFFlYkNqakcxWmtkVkViNUFTVnRU?=
 =?utf-8?B?QmRyVEdQQVNXY09MSkdJMnZYc3hpT09zZk5GU2xWaXZieGM4cUFUanJ0TEEr?=
 =?utf-8?B?Mytua29zZUhmODZCaGEvYVd2S1pmckxpQy9HS0wwQ3poc1ZKL0tYUUY4eEhH?=
 =?utf-8?B?SUorYU13NFI0dHZVcWdqbnNFZWVIYWwrYlp5OUtkTWZxcGV1RUlyQk9SeXkv?=
 =?utf-8?B?MWJveVVjaFNIU0hoLzV4enVsaEpPTVlkSUJ6L0NBVzAyOGRqT1AwRjFnMUlR?=
 =?utf-8?B?ajQ2OEl3S1VZOTZtclV5c2MyVEZQNFFLS1lOOEJ3WmVhZkhvZ2hNRDVzRjRu?=
 =?utf-8?B?S1R3NDMveGR5allXUExXTHozWnZyQkx6dytyN3ZaRjZBcEZoK0Y0S1RKaGND?=
 =?utf-8?B?UHdPUmJSY1crb3FFSUViY0MwakMwWFltajhjU3J1eUxQRmJRQ3RtcUZlQlRU?=
 =?utf-8?B?N0ZlSzg1NmdvTGlYSGRWNFYwMkRuYmdsTTFmVUlIUWplczUremRiaENKOWZ6?=
 =?utf-8?B?cEFXQ0xHaHkxL1F0eC9XcmJEK25DRG9TZEtVMThIdll0MVpYR1kyRXNldGlG?=
 =?utf-8?B?L2dmR3N6ZjU4NU1YQTFUV0k1V3dTTURhYlBOYUVqTVNvSUoraUo3UFF0ckZt?=
 =?utf-8?Q?u1b3Qd8XVohxg97yqv408Ys=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5FNtStINtqSSFchNiO52wCoEioP+cdIJ1S0tAzNm+6MizrseMOZg/aWteXdL61aJTtZyt7MXqSFYbrVt+KMt3N/LRu8HDWGuh5n58Fl4hZBdzBfsfpeId+EsUIf0Z/b8/XE3aKn4mJwth5E3VZ3lXatoX323xYACeQH0budMbhc76s7IcIzamTscSk0+JnFwlXCo0/sVXxyFaJJ23cYdXUFCTNlrKciYIDOaUw5sl2tc+AnY3pcNMtW+A6lE4dd39tvZETYj0qTcTPKgxHZ9x/eOtsLP5au955hEIG/aXj03A5z2dPo6BKV1itGTyW+GnbUUoqAJC+HL8f+Z9ZHG9SMd/qOc5HBHD6n/0QlK974NUoRn9m96dTIhHgV5HlA5s8gFVH/nJxG6SJcOOYJkvG66AgYnL41Ip9KBz22EAtydc0qCDLCP0wuAbxdRGCaw9kjW/puPE+Iu1JZh8ntrLwdAqcsgjMazyO8WWN3b6481HF6OJ68m0hyPIV37XeSLk+8BEYennGEFRWUNBCsmNJDiFS82Qkx4Ogl9OdCPL5h0U1sq4xG9sM8FlypohzP0OTa9nnqFDRBYdOJVxGU1DsmYO21yGyzzknOtqTZ2hdM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec59e8e-5388-4462-1e2a-08de0b6b2b8c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 21:46:45.4139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5e5Eng64Vw7IUhOXeglg2Q0SY99PRJZOzDOFxeOU4XSkemeKH8hVFrjIf8EAT7jXT28aUBH+F1t/fMk0QHC5pyXki6XPuT1iIi1VaLBC5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140147
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA1MSBTYWx0ZWRfX28danjuYMoiL
 hk06gSO8/emnvGF3b9tq6cRdKe4MyLdKEMizeuA/PVN2Vzpq+bH4AIwOfrcIoaJnAI6X1rLU+uH
 35iKiMDXco491o5oEp3HAXfqHqTyHvXZiIE48dHHkkkc+0sNC9l77k8nGed2ujq0UCl8XDkeFYG
 zOnJfiJofrl8jkeBqbfZ0EntKE2YxeF21ipNORM/vyYZQvEIu4NjTwnhuZr7pI59WjJ1c3d/NCE
 ZmDAGCEt9AQ7l34P3kDpf+b3htPn4WzHicn8pR1rOvo+UfX4EiNM/RQ1V5xIBdfkD7JT/lwynqd
 sr22ea6tCnJyau74X16HJwzAjGU1kHavVx77eeu8ggEb956jyJWIhVfGKyaAKMWRG0YViLtIg0Z
 N32PdsfeUm0rsyZnIj/T0EJuPiVl6bQWIZDp6pwGFp9LkyYNYWs=
X-Proofpoint-GUID: al20in0XbrEuUmKeiaIVhy-0rx2FwOSH
X-Proofpoint-ORIG-GUID: al20in0XbrEuUmKeiaIVhy-0rx2FwOSH
X-Authority-Analysis: v=2.4 cv=GL0F0+NK c=1 sm=1 tr=0 ts=68eec4cc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=GVY6CCMUbiw8bYCG0tAA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13624
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/14/25 5:02 AM, Michael S. Tsirkin wrote:
> On Tue, Oct 14, 2025 at 11:13:51AM +0530, Sairaj Kodilkar wrote:
>>
>>
>> On 10/13/2025 1:45 PM, Michael S. Tsirkin wrote:
>>> On Mon, Oct 13, 2025 at 10:30:45AM +0530, Sairaj Kodilkar wrote:
>>>> The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn
>>>> for indexing into DTE. The problem is that before the guest started,
>>>> all PCI bus numbers are 0 as no PCI discovery happened yet (BIOS or/and
>>>> kernel will do that later) so relying on the bus number is wrong.
>>>> The immediate effect is emulated devices cannot do DMA when places on
>>>> a bus other that 0.
>>>>
>>>> Replace static array of address_space with hash table which uses devfn and
>>>> PCIBus* for key as it is not going to change after the guest is booted.
>>> I am curious whether this has any measureable impact on
>>> performance.
>>
>> I dont think it should have much performance impact, as guest usually has
>> small number of devices attached to it and hash has O(1) average search cost
>> when hash key function is good.
>>
>>>
>>>> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>>
>>> love the patch! yet something to improve:
>>>
>>>> ---
>>>>    hw/i386/amd_iommu.c | 134 ++++++++++++++++++++++++++------------------
>>>>    hw/i386/amd_iommu.h |   2 +-
>>>>    2 files changed, 79 insertions(+), 57 deletions(-)
>>>>
>>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>>> index 378e0cb55eab..b194e3294dd7 100644
>>>> --- a/hw/i386/amd_iommu.c
>>>> +++ b/hw/i386/amd_iommu.c
>>>> @@ -59,7 +59,7 @@ const char *amdvi_mmio_high[] = {
>>>>    };
>>>>    struct AMDVIAddressSpace {
>>>> -    uint8_t bus_num;            /* bus number                           */
>>>> +    PCIBus *bus;                /* PCIBus (for bus number)              */
>>>>        uint8_t devfn;              /* device function                      */
>>>>        AMDVIState *iommu_state;    /* AMDVI - one per machine              */
>>>>        MemoryRegion root;          /* AMDVI Root memory map region         */
>>>> @@ -101,6 +101,11 @@ typedef enum AMDVIFaultReason {
>>>>        AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from guest memory */
>>>>    } AMDVIFaultReason;
>>>> +typedef struct amdvi_as_key {
>>>> +    PCIBus *bus;
>>>> +    uint8_t devfn;
>>>> +} amdvi_as_key;
>>>> +
>>>>    uint64_t amdvi_extended_feature_register(AMDVIState *s)
>>>>    {
>>>>        uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
>>>
>>> Pls fix structure and typedef names according to the QEMU
>>> coding style. Thanks!
>>>
>>
>> This is something I am struggling with, because the name
>> `AMDVIASKey` does not offer readability.
> 
> AMDVIAsKey
> 
> 
> Or you can update all code to use AmdVi and get AmdViAsKey if you prefer.
> 
> 
>> Maybe we can come
>> up with an alternate style which is readable and does not
>> differ much from the current style.
>>
>> @alejandro any suggestions ?
>>

I should have pointed out the CamelCase requirement for the typedef on 
v1. My initial reaction was: "do not use typedef" and go with the 
slightly longer 'struct amdvi_as_key' instead. The style guide has a 
warning about typedefs (which doesn't necessarily apply here), but IMO 
still better to avoid it in this case were we are not really gaining 
much from it.

If I were to use a typedef I would use 'AMDViAsKey'. After all, the 'i' 
in AMD-Vi and 'd' in VT-d are lowercase ;)

But my opinion is to avoid the typedef altogether.

>>>> @@ -382,6 +387,44 @@ static guint amdvi_uint64_hash(gconstpointer v)
>>>>        return (guint)*(const uint64_t *)v;
>>>>    }
>>>> +static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
>>>> +{
>>>> +    const struct amdvi_as_key *key1 = v1;
>>>> +    const struct amdvi_as_key *key2 = v2;
>>>> +
>>>> +    return key1->bus == key2->bus && key1->devfn == key2->devfn;
>>>> +}
>>>> +
>>>> +static guint amdvi_as_hash(gconstpointer v)
>>>> +{
>>>> +    const struct amdvi_as_key *key = v;
>>>> +    guint bus = (guint)(uintptr_t)key->bus;
>>>> +
>>>> +    return (guint)(bus << 8 | (uint)key->devfn);
>>>> +}
>>>> +
>>>> +static AMDVIAddressSpace *amdvi_as_lookup(AMDVIState *s, PCIBus *bus,
>>>> +                                          uint8_t devfn)
>>>> +{
>>>> +    amdvi_as_key key = { .bus = bus, .devfn = devfn };
>>>> +    return g_hash_table_lookup(s->address_spaces, &key);
>>>> +}
>>>> +
>>>> +gboolean amdvi_find_as_by_devid(gpointer key, gpointer value,
>>>> +                                  gpointer user_data)
>>>> +{
>>>> +    amdvi_as_key *as = (struct amdvi_as_key *)key;
>>> this assignment does not need a cast I think.
>>>
Agree. And assuming you take my advice of not using a typedef, the line 
should be:

const struct amdvi_as_key *as = key;

to follow the style guide directive of using "const-correct" pointers. 
Putting back the static qualifier from my earlier reply:

static gboolean amdvi_find_as_by_devid(gpointer key, gpointer value, 

                                        gpointer user_data) 

{ 

     const struct amdvi_as_key *as = key; 

     const uint16_t *devidp = user_data; 

  

     return *devidp == PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn); 

} 


Thank you,
Alejandro

>>>> +    uint16_t devid = *((uint16_t *)user_data);
>>> would be better like this:
>>> 	    uint16_t * devidp = user_data;
>>> then just use *devidp instead of devid.
>>
>> sure
>>
>> Thanks
>> Sairaj
> 


