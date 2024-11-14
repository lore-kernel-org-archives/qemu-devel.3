Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA81D6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBefg-0005t5-Fu; Thu, 14 Nov 2024 13:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tBefc-0005qD-DD
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:34:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tBefa-00020h-P7
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:34:20 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED1s4m007681;
 Thu, 14 Nov 2024 18:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=7TKfS0gMcEIw/m6HL+GMYDaMuqQahBXxgIDrRqnqEhQ=; b=
 VK92wKYKW4G87aYZUn6pjzLt10lJ8TlPvxpyn77FP4PKbLNnX9ONoePsnYCVI7A9
 7s6ysfQrwgiYbtjr3auB5VDFTiAW1UREdl1spJrShFe1nn7RiSyMrvunt5tsU4Ao
 h+j/NxEf0+IhgUC5/OPHnFXNUReROTPsMD9sbPRoaWnCOetlYgpnmQ+l7ujXOHK1
 tW4kWe9EXVXTuIPOG8BGR09193qns8Bw0NAiAzjk4bwwJJCRYYhlqrCGAz+ZqxQ8
 reZeHXt2enH76zLQ2oaWPZxxm27gaHuPX0odnwdffGhIKqz2XlcDXxrDkyqL/8BU
 dMVVUFj1NrBWFdelJPjhEA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwsxhe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 18:34:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4AEHWQ4f022785; Thu, 14 Nov 2024 18:34:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42vuw1pn89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 18:34:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYtwsdsCnUyGQdKnTarMvt1OkdF0a/xmA4/FKlzAE3ebm9davZhSTZ7ywsUmchE5hFTwm/8q9xDbvR4ZrU3++pf1av3qelKnuHbxcIvmsPCH9Volsg72POIDusZXlV2mngj0gO/aYix8RgJRM2zYRW8OsDfRAGYgq4EWsgCmYjixujyWpOl9eeH30ZjtHcWr9MOc3T7Rb8mq+kTIWRmLoGNdy7z7u5mAkisFmA8hvsbh2llz6Q5YwkEsqdtWh6v0a8+BIPYFkp4gRMCQWGOO+XThGdXtzCWQkgIH2CY1BwyEzBMzbmODb/QL60wko5HIjQmc/Q03D6TMaTTxSN5RWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TKfS0gMcEIw/m6HL+GMYDaMuqQahBXxgIDrRqnqEhQ=;
 b=q6Kke4Lpljql0+nSsg0BYa8FtW71cw4LZbv3FgqpNtZGD1wdy6FXF1lOLmdfwDhrWjamuOXXFa2I/x/nNcTSals7rCnsSItAeq2ofq9qaEyqJBmerYL6tXCKCEOlmkO3iAS+00P7VKdlVJ93jCD6ubqR/8Nw7t//WL4gtWN9GPvSLw5v38GKEgxafC4gSlv9Ti3tgkURkBWu45Hh12nR9FC6wNy3t8EkRkcVpzCdSPwFOLl/52knEnrQkcEZvI3zHkrQ+uSh2DzdMS4Sw4R/12qnsyAx0CWNfmcKko0aSlonULOmGD28dLcNfQH07L2jP4LB+81qWWFQ7EVgJO9e6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TKfS0gMcEIw/m6HL+GMYDaMuqQahBXxgIDrRqnqEhQ=;
 b=CzXUumLxSxgeL30Y7Ch6PnfQVLUF5UzrlZ6xqW128K0SZW2G7mnAaOLgvTxZ1sOoN9Cv8LBn5Yae/aA9PwM1a7GC3gnM763AVku7IH5fbke389OMJengX/Gl/WgVTe3bvB4ilq92qPIHhQcldM1n5Xh+mwPyRGKAtxIEMCLzURM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB4807.namprd10.prod.outlook.com (2603:10b6:510:3f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 18:34:10 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 18:34:10 +0000
Message-ID: <79325f1e-6680-4d75-85b5-2fe6d51c287b@oracle.com>
Date: Thu, 14 Nov 2024 13:34:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 05/16] migration: SCM_RIGHTS for QEMUFile
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-6-git-send-email-steven.sistare@oracle.com>
 <ZzUR92pCcSn2U5Pj@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <ZzUR92pCcSn2U5Pj@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:408:fc::28) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 961a8b2a-ee3a-444d-0b91-08dd04daee22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUFJL2xFbUhLaXFzdEFTZXFJL1NUajR0V3ljRHc3U3l3WVZ3dzBaU1c1NkVZ?=
 =?utf-8?B?bW9EY3NMWXBxTGVORDg5YlVxMDJYckhadnVHOU4zZ0pWRjFlSDBSeklOK2w5?=
 =?utf-8?B?cUFGdEhnMUhsZ2hCWTJxTENENkVUcXNmWENzNVhxZmFJa2Z1QU43UThodlJD?=
 =?utf-8?B?OHVqWFRUcXZxUllQZ0MvNGpXRGE5b0lpd2Q1NVN3QnFiSjIzMzlETkVZMFdZ?=
 =?utf-8?B?OHVPZUgwbm9oUnFEVi9BbmxkQkIvcThRQ3RVZlZhK0JJTWxaYWRHMDRxNzRY?=
 =?utf-8?B?SDV4OUhSVjFjTFVWQ0JVMEhOKzJ5ZmVOaGYxMXJkN2UrY0tRRHAvY1RCUjVt?=
 =?utf-8?B?U3ZpOU52eU1vRWd3c0o3clRRVnFhM0lpblpGRENsWXN4ZE82QXpDOVQ0a2ww?=
 =?utf-8?B?QkQ0andXSS9FYzFuVnVNbTFZQWQweWVkaVZVWGZ1dHlBdDR6cUpYcmRQOEt0?=
 =?utf-8?B?dHc0Tytrc0dyaFNoajVRVEVWMGkyRTRTS2VreGI5Unc4cGVSN3RXbGdzclFu?=
 =?utf-8?B?S3VCTmhEaHZaeGtNUDFiT3JpT1pXbUlDeityUzMreGtGL0NJMWJsekdONDFT?=
 =?utf-8?B?b2F0WU9qYmIwemZCMUlEM1hqZzNvaVZ4VFlmQ2I5dS9zenV2eDE2TzJUWm0x?=
 =?utf-8?B?SUJPMm5UNTlFL2lXRDVrQTg3Sml2UHQ0dWZ3aXRRNzhZbUJoNTJUSmVVZVNi?=
 =?utf-8?B?Y0dxMUw4cHdzVHhYdDVFRVNMcGp2U2NrWlhTcVRzamZBR0xNOEhkSzdiTXQ4?=
 =?utf-8?B?WWJMd1g0djI1blo2em10NkxpcFRYSGVCeTR1QlJKSVc5dFd1bXE4eU9CUy85?=
 =?utf-8?B?NGRwcStRell1a3g2bUxaNjNHdUxyUjhGMEcxVCs4ODV4WG55VjIzRm81NnRC?=
 =?utf-8?B?RGhPZVEyUlVTdDA3Y0JYdlNyY3VQT1FoMzgyZFZuZHpwcy9iL01rUnNCTU1W?=
 =?utf-8?B?VDNwOXhFN09LRGJrUnk5emNZL1ptdnV0aldUZXc4Vk5lZklYalhzSXZGc2RK?=
 =?utf-8?B?eWZsQzhwem1LSjUvQ3RQQzNFeXJyWEYrdlh0K3RqN2Uwbzg1d2E4ZGk0SXhY?=
 =?utf-8?B?MGszaGQ1bGhvYzJLRWQ4b1cyYm1kOTNka215QnZ6UXRHSXlQYVB4VGgwNXVQ?=
 =?utf-8?B?OUhJQ2wzU25IUG1Qd0pCcHBZSXhORW5NNmNSVVNienBLajVuRTdWL290clY0?=
 =?utf-8?B?RTl6bDlaT1RWUksycS9jSlI1UHVFMFc1VmRuYngwRGo1SncyTFJlejhVbXMw?=
 =?utf-8?B?b2kxSEpSVjMvWk9ua0c4NU8wZnQrRmE2WDZvUTZNaDJpUmg5QmlOMXN5Yjcy?=
 =?utf-8?B?L0JVMHRkWHRqY1o5YXgvVk8zbzhZNHFRQ25XeTJRSlFYK2lyT3pnaHhQZE1N?=
 =?utf-8?B?cjA3ditvV21YbGJJVU45NVNhdEFDblkvSHNMZGxtZHhjZlY1eHhWQUJTTzNT?=
 =?utf-8?B?QmI0Y0ZHb0hwZVMxNUl3T0M2QUlVOEFwVUdQcDYybWZTY0FodTVoUVE5V1pS?=
 =?utf-8?B?ZktzalliaWUvMkZTQkRoUE9lVDBZOEhsYSt0SFZDRC9oTFB6UllnVFpyUUc1?=
 =?utf-8?B?ODM4SGtmdkFHcXJrZDVadXkrUm5iMGpRTDl5ejZDTWgxOUh0OFV0U2pnVTZa?=
 =?utf-8?B?L0IrdUhXWml3Qzl2Y0RjMWtSS01UZ1F5QWJ1eVAxWDVMbi9qaWxEZmZpMG1E?=
 =?utf-8?B?V3lBRGVoTDEvQTRLT0JnR2Rmb09HR0k0RHk1RlNFOFZDK1g3eFpiNHpmMmR0?=
 =?utf-8?Q?awmdg60iKHUwuPDYU2+6HH64h0UlQZsS2QcL4ks?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVRmYW85K0YwbnlwOXNLMmplTmRHRzZZVE1DM3p1bjFQZDJ5M1BIbi9JcHZF?=
 =?utf-8?B?NGZQN1ZnbUo5M21IMUd4Y2J1azg4SlFGR3FXQXJnNDRZUUVTTVIzNS80b01o?=
 =?utf-8?B?Q3R5WGMzNlNHR2hMOVhzT3d6VGtoVHNGRGVaVW9ES2J1MWVSN3p0YndHdGJ3?=
 =?utf-8?B?aUptS2ExYVpzK1ExY0QxMEVkelFXVFZnelBRNzE0VVFjMG9EWGVrQ3p3NCt3?=
 =?utf-8?B?ZnJha25Hb1hCYVFYSklHSlBrVlkvdmtXak80cy96Uy9ERitKK3RUaFYyVGRT?=
 =?utf-8?B?c0FuTUk4ZUtEWWpxYXpkdzhidmFXNE1rbkVIaEFiVkM0Qyt2VTBEUW5YQWlC?=
 =?utf-8?B?WmpEaGVXYzVQZk95RmVjaU9MejZ1M0NQcVBnOEtmLytRblh2cWhQdnJiUGxz?=
 =?utf-8?B?RGJTZVNkWFEyTU5hemUwc0Jaem1ldVZHeEFHaW9ISXQ0c0FjRU8wczFLY0dQ?=
 =?utf-8?B?Z2dUMWtuMkdpVmdQQ0JSYk9XTWhzQk41UXJiVkhOWElkK252Zkc3d0lOSjlL?=
 =?utf-8?B?ZzkvZko1RGU0TnhDRGU5VmxGU1lDM1dRS21WWXZZYjg5RytQVEJXRnAyeVhX?=
 =?utf-8?B?SUI5L1VGcVdCdllrSllYMTd2ejcwVW5EdTNoZnFjczlaVStHR2dXK1M3SDhP?=
 =?utf-8?B?WmUzdmpoMG5Sc29UUTB5QjlKMFdIM2w5QnY5OFVoQVJmY1pRZURZRzZaVHBu?=
 =?utf-8?B?QmU4TjVWYWRTVDFhMVdiZmVmZHZJVC9JYkxZckFNN1IySHNYeDVUUlFJcmJy?=
 =?utf-8?B?bmVRalhTNmtNeGhNays0NnArNE1KUXk2OHlRTDNCRUJJM3hzNVhINmZqTmFK?=
 =?utf-8?B?dWhLdG5ocVNmbStjam4yZ01HSStVK3BDOENtYnhZRGEzaUtzTitsM0s0bDIx?=
 =?utf-8?B?YVJpeS90NG5aWjAxTHVFckxmaTlKNkFuQnpvdFdNdHo3Q20xNFpTa1pNZnVM?=
 =?utf-8?B?dHBhbHZucUJvcXNzYWwxcS93NjdCbDdUK0hWTW4wcmhpZHhGK2VwcVB4Mnlx?=
 =?utf-8?B?eXNEZjE1VHBmTDNuKyt5ajF6MC9abjh5REJMUnI0N2sxdXNETmlFckhPWjl2?=
 =?utf-8?B?MG1NdzFFZ3hVd2tCVkZRZC9kYk1oemdCbzVQaVVRN3UrTDJ3c1BpTTRKa1Vl?=
 =?utf-8?B?ekF0MnpGWVBJYnFjVkEybHRXeGswOWtGYWRoMndIU3ZCMk9JTXdsa1MrdkRo?=
 =?utf-8?B?NmxvQU5wZUlJOWxQdVB1dldLc2V1TzJMMU9hQmtKeEhTM1N2dUIvQXpCc2JC?=
 =?utf-8?B?UXV6OXZkZHZWRkIrL1lYZktQOXRmWWptK1Qvb00ybSswRHpTMHZKTU9wa0tt?=
 =?utf-8?B?OEhvN25RU3cycVV4ejNSZFV0KzI2MmZGK256MWhDNEhoWW5WWDhFZndiaWRl?=
 =?utf-8?B?Tkh3N0tQc1lXSjdGZk52WTR1TzJJVU0wdlMycVNmbmNyaTlYWnBmVXFCUUI1?=
 =?utf-8?B?d0lyTzVtd1A1Tm9YSVVnWEJ6WERVeTRyNVpnK0grMnpQZDMybFdYU0JjRDg4?=
 =?utf-8?B?YnVCVC9oTVlTNUFiUHliZy8yOHVPWFhSajkvTGwxQ2gxSEhjaFhTTnQ4WHpW?=
 =?utf-8?B?eHNuTXVXc2xqUU5pV21OczFMTWdnUVE4dnNhTHRtdkYxZDZIcXAybGs2Wmx4?=
 =?utf-8?B?UnJVYUlOQjg4TElwZGdFZlJIMktZaEVJSFBDMElrNzRVa3FRTmhsa0xPVitU?=
 =?utf-8?B?aVpKbW5XKzFDQTdjOEEzTk1oWEFidVpOS1cycFh5eW9TZ2lPUFh0K3JOeUh4?=
 =?utf-8?B?UitMY0dzeGdnQy80aG50S3JLWmVXaVhxcW9UVElFc0xTV1N4NnRxRzVLdWdL?=
 =?utf-8?B?N2x4MlJUYmlML29ZSnZwVTN0VUM0ZEdmU3d4SVZHSXc4emF0VnBZNGtSdlVM?=
 =?utf-8?B?NWFSdXZFWHFoOU95dmp5djZqb2g1TzZlaTZzRHZRSGg4TXg3VThoRHFIeU1u?=
 =?utf-8?B?b3NMdGZ3bUdrdDBNZXJxbFN2ZGpqeUlBNndnTThENVVxSjZZbGpSd204SkZw?=
 =?utf-8?B?OUdURzI2VGQvejNJS1dqamRFNHlEbzhSakIwVzdtMXVFUXBiNDNMNjBsSHJy?=
 =?utf-8?B?SnJtS3ZFOUFOSVk4Z0p5QmZZNDdNRDkzZDhiYXBnam1nRERmTnRoUnVsQVhG?=
 =?utf-8?B?cnRjUjViRHVYTTNsT3RWVm13TFQvL3RSQjIwSHNZN1hVM1prNXdPWUs3SDJs?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6XbCpE4djt4LcOJQqmXHELHTKF4283QuxwKPEDJtNg5A6kMOykeRBMKJF3wXQgNc+tyTrG/anpHdJ6BEUHtrWKRQCv4zkUxaDBBZlMrsLId2/wmeVR5kSeXV5UMMqQr3mKDdXLE3jp/2mEBzHObgQ89oSwWFRuZRIU9mf0lJQT94J2vzpXJdFdTAnfit+xbYQkjyr7Cg/ZblzvJOHwroQeK/jvzUckZfdPj/SLXwIbVk3Nv4dg8hxLi3c+aBs69SQV0pibUPC087eHOCnmcSCi3K50fsD78itXKqwXCqyIeQOLoZWd10TDa38Vhg+Uodw/Xj6rYerO3r5HY8DCrJx4gkzH0vejFRdQ0XLifLbPXpBo/1eX3ngre/mlKPriy0qq0MiuC8EH8Gd56S5gif3t2Y7TCaG/CxaCjF34hf6cnXBQOL0Py1sp83sN+zOYccPHbzlQGVhUzXIGcHHBUw7ui89oO2g0D4267l7noBhn+TZPwoTJ/pjpbvzphpG3TGsDvOSZoWw9BsokRRPOaDspSJobGQyAoMAXH6eQWj3D6MryTRTfB64QHEP/uv3duUYU6YfMtegGV/3A09Lq7VT+k/aE2rMC3kUPJerbO5PGk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961a8b2a-ee3a-444d-0b91-08dd04daee22
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:34:10.2343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCECmmPROL0dAMy7cZsG5ul2VM1UTjW/ZNB9VlsNMCwT1J4OyMFnGeU/JkgrJb8x5L9N19rmdUNwKQpKHOC+3vqkC18eOxDUJLGl6Q1nQ6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140146
X-Proofpoint-GUID: mEw-WMLUCCMwK0kLnLoX1W2FSbPTTbiP
X-Proofpoint-ORIG-GUID: mEw-WMLUCCMwK0kLnLoX1W2FSbPTTbiP
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/13/2024 3:54 PM, Peter Xu wrote:
> On Fri, Nov 01, 2024 at 06:47:44AM -0700, Steve Sistare wrote:
>> Define functions to put/get file descriptors to/from a QEMUFile, for qio
>> channels that support SCM_RIGHTS.  Maintain ordering such that
>>    put(A), put(fd), put(B)
>> followed by
>>    get(A), get(fd), get(B)
>> always succeeds.  Other get orderings may succeed but are not guaranteed.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
>>   struct QEMUFile {
>>       QIOChannel *ioc;
>>       bool is_writable;
>> @@ -51,6 +56,9 @@ struct QEMUFile {
>>   
>>       int last_error;
>>       Error *last_error_obj;
>> +
>> +    bool fd_pass;
> 
> One nitpick: I'd rename this to allow_fd_pass, or any name clearly shows
> that it's a capability.

Will do - steve

> 
>> +    QTAILQ_HEAD(, FdEntry) fds;
>>   };
> 


