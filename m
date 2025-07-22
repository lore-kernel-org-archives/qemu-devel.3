Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B13C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 22:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueLLh-0008Os-Uy; Tue, 22 Jul 2025 18:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1ueLLf-0008Jl-A6
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 18:20:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1ueLLc-0004T7-Eq
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 18:20:35 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MLDfOW024172;
 Tue, 22 Jul 2025 22:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=paDpuDrgbRhfNCA9MWC/xn+UqfSobCagJ0vwMQglPqM=; b=
 ZSUENcp4gsajvh8DA2tjKBrtw7Bz5ProXxqWEW+dmBDUBjU9SXP7lpnGqEWLOZJ3
 334Iy2K6xgSGRuNUD8+LVXkNdt/SAzrrWQ2ZQQLOT/8GvYt31DeBDWEC8WT7TSeV
 6LflyDHK4w4Ue7V4PYMNrLZ05Qt1QiE2+crYX+owSYUMtZziWErxj3S6gpjMtTHU
 73OIWU+EaDMXoxhOLCFGJsSqgnWwkxK0OaFSj+SLwe1q4mCAZNzDTNQn6LZuZ4TF
 RWsSn/7j3g7b9KH9vcaVeOEUy+3Pm/zLt0cus+Vm38JqvI1meqsAsSWU3VO88llt
 PlkUQbHZjuIHFG8eUTzO6Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48056eec8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 22:20:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56MLvLfW006154; Tue, 22 Jul 2025 22:20:25 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4801t9vnxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Jul 2025 22:20:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXL78Yzf3g0J5+oLRm+GelavwfE9ltQVxoqDF89SN36MQPKhuPKgyoZy5Y+7+HoqwA5yLC1olNVVKBwqRN/FwXvFHiuEmL8KwoVtoRJhdF/oiilW6yCjrDKzzDF2Nn54Sg2oLl48q7ztlP6h7bTwc+RY1yBGvEdZUA33+DkaB/W9ANczLbWiL7oHaH5q/CLkQaywWP1OypNm5v1FD6+a6tb1OoJhUpj1jOqJUghcUykHg+j+Ii2CpotNrY8S/kP3XWpdRNKxnty97pD9vfdAYyshpsh1YC0yaMnl4vyan7PWyypXz6xUBV0HxusCqbn1qsxZeihcd4zz61V1/K8UhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paDpuDrgbRhfNCA9MWC/xn+UqfSobCagJ0vwMQglPqM=;
 b=grrsD1ZdMR53rFuV7J0TQJAlgji8SY9i8DO+llMzp5SSPVlm5+jvLQoC+JraiaFukgRDzF7Lhi/TjkMxUbHxKZe9QwRxiCqROa0Nx5bAefhS3iDp5yIQfevcIYAFIXi6dtnLWpBUAPIuIS6pkX92flm6rB2DH8UC9Z8yz2A3HovN1Y0YRGPglGCrkYrq1kTJgeUHfcwzDDQqxQ2QjJKodo8nTw+3ldm8KoW81DXFGpEfpA1Ab4dYIhbMipOjg9bU9SBXOA5wf5VmpCGiCfb+b57NbZYIKs4BEq2XfOFpEG8rz339aEjI4eAonkHRXYYeYUabb9ihyofYuFV8i2SjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paDpuDrgbRhfNCA9MWC/xn+UqfSobCagJ0vwMQglPqM=;
 b=sTmMPs80zXdlJgwdbNQge282s1QUKXL5jxU04yrOdrAowdONRi73AEvPPzcsqPoC/o9qDtSKbw/KScRi/YzhgfjMVe2g7tLVQ+s5TuHxqn2xpMkU0DBdKgyxVp1gBKCE6Za18OT91Vhj7GcHDyFFvMgtWdlle5HLt4w+rJF2RFI=
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d) by SJ5PPF7F0BE85A1.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7ad) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 22:20:23 +0000
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::3a33:775a:881f:ebcc]) by DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::3a33:775a:881f:ebcc%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 22:20:22 +0000
Message-ID: <77042e2d-d65b-405c-894c-5ecae41bb7ce@oracle.com>
Date: Tue, 22 Jul 2025 15:20:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: fix off-by-one and invalid access in
 virtqueue_ordered_fill
To: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, jasowang@redhat.com,
 boris.ostrovsky@oracle.com, terrynini38514@gmail.com
References: <20250721150208.2409779-1-jonah.palmer@oracle.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250721150208.2409779-1-jonah.palmer@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::17) To DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF18D5A7206:EE_|SJ5PPF7F0BE85A1:EE_
X-MS-Office365-Filtering-Correlation-Id: 30464604-a62b-401d-0946-08ddc96df292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|42112799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzdlVU9mZHZqM2RsblN0MC9TODNZU3VzK05jQTFZU2hpeG1vNnV2T1NBYVdt?=
 =?utf-8?B?dmttWFdUMzlDTU9oa0Z5c1Z4eCtVazhXSnpkeSsyNVBxdXA1dkVUbHhUZVVE?=
 =?utf-8?B?Q20vUVJFQzhVSHZOclorRTBqQm9zU3lHVS94aDRDL3dkTURKbE9zQVFOSEdH?=
 =?utf-8?B?ekxpYzFGb1RkdGVQSWxkQk1ObWNZTmRnZ1l5a2hjVEQ0dEU0Z05XaWt2MUxE?=
 =?utf-8?B?ZTVSSWgzajhyNmtMOGRDcmJlTnp3eEF4QWpGY1RSMzBCdTVHemJyZGluTDc0?=
 =?utf-8?B?aVMzOHYxQjEyaCt1a0JWaVRVcFh4Z09CNXhCVE1MTHJ3VjFvSExEQUtrNXpD?=
 =?utf-8?B?cGRSY0lNSzZON1B2UmZhb0Jab2tLLzJKOU9QbkUySzFnRDdkaG9KRFFVazFz?=
 =?utf-8?B?and4eWExU3c3Q21NaExYNEZKSTJpSFJmVWdGTlBvZjZjOWtlU09NRmczYzNm?=
 =?utf-8?B?MS9QK1AvbDM3NkJZTXZ1TEtZTWxoNTNaMWVPNnpBN3dvQ2liazhMTjZSbTBC?=
 =?utf-8?B?eHQ5REg2VWt6Y1R4UFBUKzRsK280b0Mza1NlK002Mk56bjZBT1J5aE5kbHZn?=
 =?utf-8?B?bWxNT2xBUks1WlhWN1VsRjFXbyt2VHpHb2R2TzdPdDZTSllvbkV6OThFcW5s?=
 =?utf-8?B?RE9OMnk0NUhKWUc5djNIQWdpZDg3bEVEQ3ZpdnMrbUxEaWpqNTdPL0pZcGNR?=
 =?utf-8?B?djJZdHRQMzdsVTByRXRXR3lxY0h5WTlyV3hUQjI5Vm9WWmxiZ0RCZnN3ZGp0?=
 =?utf-8?B?YlpkWXlPb3JtaW11ODV5YVVUcEd0ekRhZ1d0d1kvNHJSTy9nTW5Kc1VEMGZD?=
 =?utf-8?B?MXVOdmhnV01pTzdNeWRuYkc3L2d5RitMR25uZ3dMTVc4dnNCT001eGJrWmRw?=
 =?utf-8?B?VjhhQ2VoMnBnYTAzQnRYRk9qeFRjWk5KVG1kdlVYNXZtK2VtWVY3VjlOamdS?=
 =?utf-8?B?aUZweGZLZmJ4QU1jMTJNTUdZaW9mdjVaREFhQzVnZnRTbjFtZGtFalptc0xN?=
 =?utf-8?B?K3g0UEp3dFh0Z0FOYWlEMFh5Q09XZVBxMUpUTW01bHh4b1pwK0tPK0cwazBz?=
 =?utf-8?B?R3NnSytNRkFnckhHaHBOb2hsNFF2aFlpUCtFU2hRNnJZaEZSQ2dVL3VXV0ds?=
 =?utf-8?B?S2h4UjM3SmhXSUVoSVZ4UjVrUmlHMVlxU2hDQ1BJKy9uci9qN2hCcGRoWDA4?=
 =?utf-8?B?c0YrVVBUZDdsY0JGaUk0V3dWOWFXRFFhU1pTeUl2NGZuTWJYRmNybXJjTXd1?=
 =?utf-8?B?N05CZ0c4K3kyRFU2NlNqOU51YkNGaTduYjNyUTZveWZVUWZBSlJkNFVaT0Vx?=
 =?utf-8?B?NHdxNHU4QzhKNExaWXVPT2VUNVhqL3JxZVF6RDJtN29YZVlpOFZVUVhEck9B?=
 =?utf-8?B?U2hpK3lyUFZQYk1FOVN3SWlKdGtaOWNtQXFxaVNEMG9nUDRlZ0w3OWdiWW1k?=
 =?utf-8?B?SkxOWEE5azFiYzZPd291TDV1SW9iaVAzNTM3R2tieGVLNS9Cd2tyRVpjNG5Z?=
 =?utf-8?B?cE01NFViUkxaNDFoL0tlNWUxN3FGajIzTnVYbzFWVFZCVmZ5Qm45QkFET01p?=
 =?utf-8?B?SVdhYjk4OVdEZ0Z4M09RSldKbVJ4MVppay83VzkzUjRTRDkweFNsKzJKa214?=
 =?utf-8?B?K2NyVnRFOGRBemxTa2FNN0hZRFJ2OFZpQmVMMDl5L29EMW56QmF2UlZRUXYy?=
 =?utf-8?B?ZUk2d3c0M1FrdUd1aXljZlM3UlVFaGNDdnRmemJEc1NHOG5ybWV1R1lzSGFq?=
 =?utf-8?B?UUVEeDQvaG80b3gwK3dmd3lIallUM2NKZG9FUlVxYnBmNFp5NmRBYnZJYnNP?=
 =?utf-8?B?THEzRjErSlNYOXNOeVdINmc3ZW9XaHo4TEZQK3FZTEdRby9UNDJRSHRvaUJ3?=
 =?utf-8?B?cDh1UFRkUzlzNUR2c1FzMXZlU0IrN0phNjcwWlJJNlpsWUdGeHJ3dnIyTXNB?=
 =?utf-8?Q?9VKGTwFzeOo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF18D5A7206.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(42112799006); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUlsZUVOOXdCRmJscnRzZWRXTTl4cFBwSVM1RWhjVFBZcVY1ZU9jQlJyZE5x?=
 =?utf-8?B?UTc2Z21jd3BrQTZMQURnYTJON0F0Z0FJLzRzL0Y1cWYzby9HMlE3WEdmc3BI?=
 =?utf-8?B?K0pBTDE0WitHNWV5TWNBaEdYNUM4dUs1VHRoQ1FHanlwaGRRbk9XVVM4YXRq?=
 =?utf-8?B?L1ZEMXVxWWdvOFFRckF5WWhOR2tqWjMvV1FqUlNCQkhyTHlYVXpTVDdwc3ZM?=
 =?utf-8?B?anE1SUEzYmhJMkg5Vk1JOU95M00xRWlsOVcxSjFYemo2d0h5MkNZNFk5Y0lZ?=
 =?utf-8?B?WnpqWnNGdmptamhWVFp4YnBKd2k2bFpwMUJjUmh1RWt0TlBmS3h4U2lJdDI0?=
 =?utf-8?B?OEtMcUwxVHU2YklHTWliZ2ZvQ2JqOStKbytXdVRRRXlTd2piZEMxVEppZXEy?=
 =?utf-8?B?aVhDc25qRkJtS0lSaXhTVUJUZXU1SVZKcXBqRTJhMFJHYjhCNFQrT2ZwdVl1?=
 =?utf-8?B?azF5TktUYmVBQlFVbXh0bXJmUFNDVGc4TG9VMGhYU2VxVDJRSGZNQXpDb1Vu?=
 =?utf-8?B?Z1c4NHo2MWhXemtZNjBxbXFZMXJpd1l1Zmcrc3ZhZzdOTFYvZEpWNGlDNjR1?=
 =?utf-8?B?S21sNzBoYkx6R0JOM0VYOUJXSDRlaGcwVmh2UmdDdDl0cDlpUlBRdFFydHVZ?=
 =?utf-8?B?NjVOeFhkVFV3Ymd0eXpYd3p0MVFmYzQrd2k1eUtEZEtEbnkvKzZDR3hkL3pu?=
 =?utf-8?B?ZG1wcUNmSHNDMStzRU1ZejNVa1J1SmRsK3F2aGZxVnF1RTFxV21xQXplaHhM?=
 =?utf-8?B?bC9VSTRSeER1dURDNlJpVDV0VktYd3hQTnJrMVpGY0NTQm1mNXMyTzRyNEtB?=
 =?utf-8?B?c00vWFlDaHB0TWJScUhhWEFRQXIzdVBnSnFsNksvWkZDODlLcnBXdmxMUlRX?=
 =?utf-8?B?WFMrSTVUYUVVZVJBTElGRmdYQjU5MzJkUzhsMHJNenhsNmxxTlJFei82ZDJx?=
 =?utf-8?B?NVcyM3JKZ2g3OHQ2bFVUbjVmS2xJMkl3ZzBMc3JkbVc0YzQyQUdCMzNsbVpy?=
 =?utf-8?B?K1htU2J1OHVvWm5ic1cvcW95NWNrWE5kU1l3b3lJZitJenJGeTVFRmNkMklU?=
 =?utf-8?B?ak5ndkEvTUtGUTJXZmZ2R05vMmprQ2hWZnZrc3E3clcxVFpCS09tQUp5QUVk?=
 =?utf-8?B?TGNCMkdiYlZEUFB6MWJZSXVxS21Tbklya3FSV1F2N2lSOU1PMkdnMWtQUlVJ?=
 =?utf-8?B?a2cvWUgwZzhJMjQ2a2ZXZVZGTis3cG5yLzBvR3VsZjM1T2ZRVm5PaUxnbHVD?=
 =?utf-8?B?WmdHeXVqblFDbGNaQ1dNdkNIQ1FUYkwwcEc4a3FTdVdtLzJ4VCsrZUhMRVFL?=
 =?utf-8?B?YnZ0VkhGRzYyQ29mczZaMExDL1hkVExZdWx6dUMvQTJ3dVNoN3lkaU03bDlL?=
 =?utf-8?B?SGRXSW43VlEzOE5pYWg5V2s0WGNJMWV3NVBVb2FEWlJFb0t4bTQ5YzV3UDJL?=
 =?utf-8?B?UU1SR3F2aFFPUC8zMVllTGwzYUhtL2QweUx4czZ3N3VtYUpGeEZMQVZ1dEtu?=
 =?utf-8?B?dGpWdEVxajIzSFdXbVNhSC9DL1hTSDVkTUhGVmNXV0QrcnNEUnFGZTRPR0ly?=
 =?utf-8?B?MGt2MXpUQzNlaUlpVDlrb1BPOFRrUWFSQjZYSFkrSkl1SzU2TWJwblJFSHBZ?=
 =?utf-8?B?dTM5R2FlaGdUQkhaTEhQNG5xRG1hQXYyM0xTTUN1emhpQUZSZW14eHV1WERJ?=
 =?utf-8?B?Y1JGdFRpVm1XMElSMkxPa1B0ZEJtdWp0SXRtN2FkbnA4UWZDUXZCbDhreGtB?=
 =?utf-8?B?T3MwRG4vU2pRcklsUHJtdGpoa1l5Ry9qS2JFa2pDcXRucXJPeGcxd0Z4MkFM?=
 =?utf-8?B?NEM1K3lzOUc2UVRhOEYxZXdHVWZOOGJEQ3JyNXJiMDRwVTh0UDFNNC9LMmJG?=
 =?utf-8?B?R3NXVXF6T1dCeExCTEhTYTBNR2N6K0RRNDJWV3M2Q1VxNXdWTWdxNk1nZWxZ?=
 =?utf-8?B?RXNSdHFGcm5idnpjN0FkY3Jyc1c4TlVENEZCU21hSFBVYkRlbm1OVkhDQm1n?=
 =?utf-8?B?TngxZTZtL1RsRnMwKzVRQmtucHJmV0FjUi9zWGJ0Sk04T2N2UWFxUEhYakYy?=
 =?utf-8?B?MkVsYXNxd3hORWJ0cHpucTNXZGVPSzFieXFxQTNFYU5YbnZ1RWg3MXc4WVd5?=
 =?utf-8?Q?mPIs3dzY5L49kedSQepfAlH/y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WHIQB+PRqfiebrLreoSjGC5fYvktjfxzrV2vef+H6P9zVeN19m9f5KYvvftkWCUo/K5/5pnxamj99qd09Csf9QALLOd50qWz1ij58HR4hdRMGjtlUrOzifncuCynY1eh+52efj2AcBeqWUTsPjIrGn59wnvlS4Td6d+vgg0la8ap3t70ga8gqm3m3x8VLRzIWyNHBacdyw7j+CjCExy2phowuQ4Tq1Sdia1INYpXdRQloeYMi5xFI38K8Ggv6Lh+7qUK6eqwtKRVZ/Dids/vcDjUmewqa88ujOsxp3gzXDTPQBjsuNY3H2BZlX5FUxFUc3DLxtF51ZwD3muBaPFd0BRyUTKbfYhlIUM7ck+GoOeCeWvc+KGFj+mEDilEJ7Du303Rf5xYhVV5sH91dVZYwbOTP4Jl8eEYL6zcCe3xxRoExo99AU0+545RBE8/BSBTjSyk6MGX/dgpHNT8EzbUnhXYbFDDGisSyYS21xE8O/QdCygJB6GEfYKHifg7n1dlxP46b5FBvk4w8xv9usHte5OZOeBleTurnHHLXx/u6lhL9ZfGxxF9cXPy8sjgld63HNeAlbIG9bTvZZnk2MkY9H93EOlBgEF6u6wOwum50dE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30464604-a62b-401d-0946-08ddc96df292
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF18D5A7206.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:20:22.0287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+MBhRtR1//wwVqKSklSxmVAQ2xnR7BsjZH3ByNTd9uQSJTANRfkv+kg6bYr+rgkhyfeoHQfth/4JdcAIQPG1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7F0BE85A1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_03,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507220193
X-Proofpoint-ORIG-GUID: BEd5wkWoBs5Jcdx1CACuPsMHOepQkFVs
X-Proofpoint-GUID: BEd5wkWoBs5Jcdx1CACuPsMHOepQkFVs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE5NCBTYWx0ZWRfXwXFDpkx7gA+P
 8eJ/nMhCR723uPzxLHKlKtbrh4PQhkR9f0jItU8kw6YACxSXoKXbSPCLoDhqD6CyyzLt8V239mY
 NTolKwMqlkakVuWUCX8rIh0gi9R5j8j9nrF9wK6jPKJpvAef9ua//VcW/iN5LvrGKK5CRcT+goC
 L3O+1NCDU34TKS0eFBpvPVj9kmQEfGdg5qH8CzX05FnjGC9lpjgB2qxaa/3MgKsF5iyx303gNk0
 Te0JSgGCUEqQs0wWX+l/xiYTKUvuThKuu5f96d3tnh+8CPzOx4w6tndm+HHRkp4wm+xDwBgpqnF
 3ESVRSLpFq/6W8uji2+V9ko0MlcJQo6I9iZGxo8+l6/ZrgKJch6LCLYSwEEyi7xwGwdmv5oGbjd
 9//GK8Bwp/bgJ6PUayOzCO0IiOXeqfmosZz/xK7zollTcnuAu/0hC/SWNqsunpbCBTryTkDR
X-Authority-Analysis: v=2.4 cv=Ef3IQOmC c=1 sm=1 tr=0 ts=68800eaa cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=2uCmVNTDfp8tJihcrv4A:9 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Looks good.

On 7/21/2025 8:02 AM, Jonah Palmer wrote:
> Commit b44135daa372 introduced virtqueue_ordered_fill for
> VIRTIO_F_IN_ORDER support but had a few issues:
>
> * Conditional while loop used 'steps <= max_steps' but should've been
>    'steps < max_steps' since reaching steps == max_steps would indicate
>    that we didn't find an element, which is an error. Without this
>    change, the code would attempt to read invalid data at an index
>    outside of our search range.
>
> * Incremented 'steps' using the next chain's ndescs instead of the
>    current one.
>
> This patch corrects the loop bounds and synchronizes 'steps' and index
> increments.
>
> We also add a defensive sanity check against malicious or invalid
> descriptor counts to avoid a potential infinite loop and DoS.
>
> Fixes: b44135daa372 ("virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER support")
> Reported-by: terrynini <terrynini38514@gmail.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   hw/virtio/virtio.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 82a285a31d..cc1c072cf7 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -938,18 +938,18 @@ static void virtqueue_packed_fill(VirtQueue *vq, const VirtQueueElement *elem,
>   static void virtqueue_ordered_fill(VirtQueue *vq, const VirtQueueElement *elem,
>                                      unsigned int len)
>   {
> -    unsigned int i, steps, max_steps;
> +    unsigned int i, steps, max_steps, ndescs;
>   
>       i = vq->used_idx % vq->vring.num;
>       steps = 0;
>       /*
> -     * We shouldn't need to increase 'i' by more than the distance
> -     * between used_idx and last_avail_idx.
> +     * We shouldn't need to increase 'i' by more than or equal to
> +     * the distance between used_idx and last_avail_idx (max_steps).
>        */
>       max_steps = (vq->last_avail_idx - vq->used_idx) % vq->vring.num;
>   
>       /* Search for element in vq->used_elems */
> -    while (steps <= max_steps) {
> +    while (steps < max_steps) {
>           /* Found element, set length and mark as filled */
>           if (vq->used_elems[i].index == elem->index) {
>               vq->used_elems[i].len = len;
> @@ -957,8 +957,18 @@ static void virtqueue_ordered_fill(VirtQueue *vq, const VirtQueueElement *elem,
>               break;
>           }
>   
> -        i += vq->used_elems[i].ndescs;
> -        steps += vq->used_elems[i].ndescs;
> +        ndescs = vq->used_elems[i].ndescs;
> +
> +        /* Defensive sanity check */
> +        if (unlikely(ndescs == 0 || ndescs > vq->vring.num)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: %s invalid ndescs %u at position %u\n",
> +                          __func__, vq->vdev->name, ndescs, i);
> +            return;
> +        }
> +
> +        i += ndescs;
> +        steps += ndescs;
>   
>           if (i >= vq->vring.num) {
>               i -= vq->vring.num;


