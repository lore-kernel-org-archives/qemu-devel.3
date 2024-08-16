Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E92C5320D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0T5-0004wf-9G; Fri, 16 Aug 2024 13:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sf0T1-0004lo-OB
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sf0St-0007Ml-BL
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:22 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GFiRPN013535;
 Fri, 16 Aug 2024 17:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=4OvsUsY7ptVbii42cn9F70qR3LF7v2JP3P/u1Lae0A8=; b=
 h5mWwNRmUxwhiZHW6On5qnFUU5/MpAWtpYyyefrMbhjgZroN6ufwu52XWUOkdA31
 b3RKf6oHHN8yLYA0piMpIRrfvSI1tGE4J9LH7CUJJZepoxCAYVlzCtG1bCPZ40+k
 Qa9NGmOrkrpxMcpOVAAf7XWTU/hpx7+YuLblad/hZvUlp1oNJfPLycPwl0BR+yRh
 FsyMLz1mqjfKBrT0TC0VTClRhRGfNce9QqYnWnqZCIs7xHVQOKuqgbOkCWAisvMA
 JIxaRx2xg23b3QqlQpapa+JPAaGWPEloBAzs1Ltiho1+pxl5ALRlyhqVNGzt5z9w
 S01IHba/M9VH76NJz28azg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wyttn1xt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 17:10:11 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47GFiAql003907; Fri, 16 Aug 2024 17:10:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxncgwn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Aug 2024 17:10:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFsMF6gyYWfhAJ8S2GwaPVThe3Y372QukBGk994xd4ASOu1DhHpQcb9Sx3+KrFvXa11wiK0/JDZLIwj5qDKLG2VTIRh44VdhOUkHfF/6zDN0Hl/fFvXsqeAHFYK8J27xdJBvf25ztYQpTbdh/5S8vX6eF5jO5ulHwIM6GYu86sGSBP0AIOqXwp3PXMFns1GfLP8JDfDIM/ujUyJ543H2xci+3Wgmyf8S7BBQ0RTYZTXBCS+viPlQAS3OJloasMcfyn82hI0+sNjuYJ9KHj7954gQJP1Gv/XXgS6SroyRQ6ab0SaIZipfz/RhgBP10Pt0gZWWkjvGhoI1cg9Tq6MLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OvsUsY7ptVbii42cn9F70qR3LF7v2JP3P/u1Lae0A8=;
 b=f047HMEQZDvYUQTjacTmgfw+ebQDuZzeTmLs6UD8R12NubKA87jEfZK1w1edK6fvKVVP/0jiGC7AgegBwdkWh4aBMs00glancNSZ+sOdrGuR2PpZ6jgYVvY6dvs1pYEq6NKMhlw4qsLC90BZR/fdUKQEzlmjAVxkK+KdGi6G5ANuHy3c3aWQLfD1w5Ct444WXRfa4LnSJdK1m7tydCdmYfVb9TpYRs2JgVZ2OFGWg3m7pTsCqhJJnBysQRIuI8xMaZRSyL/HE55ikKeAQRxuaVVSafq0MPtfegetFBRhYSe+YPLp1hQOIVTV2TvCa6KoKp1RGjaBVcnjiV5yYwhWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OvsUsY7ptVbii42cn9F70qR3LF7v2JP3P/u1Lae0A8=;
 b=xkAAl5tMx96a7BMNrJvmxm8k2JhuQvHNRoH/lEOJN4I5+yEI8wbGN4je6DYduJ4gXZnMwxFGlEfjy+CTo+UMPxXimqLpO+iGeFy4yEG2QFuSKf+bkK/eZdNB7JVX+0sQxASiUKDnOfmWu8c3lTVqC6qE6L43wqPFOLsg+jymBgc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ2PR10MB7810.namprd10.prod.outlook.com (2603:10b6:a03:578::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.9; Fri, 16 Aug
 2024 17:10:07 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 17:10:07 +0000
Message-ID: <aa789f70-145f-42a1-a0c1-175190867d85@oracle.com>
Date: Fri, 16 Aug 2024 13:10:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 06/11] migration: fix mismatched GPAs during cpr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-7-git-send-email-steven.sistare@oracle.com>
 <ZpqUGYclrONQEuc7@x1n> <571a4f84-693c-43d4-a43a-52a53a1091e1@oracle.com>
 <ZrvFXCRPczXvCu2n@x1n> <5f763763-1479-4585-98ce-83fcec03b4db@oracle.com>
 <Zr9li88goR-YKcng@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zr9li88goR-YKcng@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ2PR10MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: eb186ec7-8896-4af6-6d1f-08dcbe164716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1grWjc4Ym5zd2NDdHhKQ0d0NzBFTzVwS0JwZXF0Skl4eVRtdkI0aVVDOTAw?=
 =?utf-8?B?RTE4Vk5MUmQ1RlRNUURKY1ptK2lKVHRqdnpDcDg2NkwybjN0dk5RMUM4WFAz?=
 =?utf-8?B?MDliTzY4d3hDcWVLMm5RR0pRVUFwK3QvNTdYZmhKT1ZtUC9MNVFZbFZiNHNY?=
 =?utf-8?B?Z2FKSTRhcDFlOGpYK09kZzNEK1MycFVlRjhGT3paclFOMlM1RUdPTWV3TjVh?=
 =?utf-8?B?Qmp0UDFQajNydU0yUFRGdVZqZlJMUFJoNlZCSXJIVk4wQ0t5NExNVGZsZ3JK?=
 =?utf-8?B?UUR2b0dwZm44OWRLOU1pUWkrdDhkS2JrazZONlhJVWNpeHM2SXBxZitIVFBh?=
 =?utf-8?B?QXYrK2tzZ3owaVpNOUllYjc3ekkwTlg1OGxTTUFUNUU1cUNvUTNyU1NGUFFO?=
 =?utf-8?B?bWVzazJCVHR3eEFiRkZUdjlyRkIzM1BSZ1lHbzJyR2NQaEZ1YWIxMzVrR0pF?=
 =?utf-8?B?T1U1djlVUk84QVRBYmNKRGxiUlpxL2ZrRjU3VkkyV1hRbnYwZ0dxZWIrU3NN?=
 =?utf-8?B?OFd0dy9LQzFtb1Izdy9hUFB6NFBqcUU0ZFZFazFLZUs4MnYzWWRRWGZEeEVP?=
 =?utf-8?B?S0FLdDlvR3p1dEFoa2M3bUVaZjdMOUJyL3FRNHR0TzZ4U3BCMGh2VU9zVVNS?=
 =?utf-8?B?LzBWOHZNWE9WNmV3YnBadVpmQ0U5MmRJQmpwQU1EdVRQSmhWdmN4WHpPSXRy?=
 =?utf-8?B?RUwwV09Qc3JWWDZXTUlrZzcrR3VrRXNvRmh5QnZqQ3ZRRjdrRmRXTUV5eWxt?=
 =?utf-8?B?dlltUTVqRlFtN25oUzNZTkxIQWdxc3JabFVTZ000MU5PVkhTNEI4UnAvQlA4?=
 =?utf-8?B?WmpBbVBBS3BtcFZTejV4MGQ2RzJHdnloamdNS2J5M3pQUTR0MUdlWWQwOURl?=
 =?utf-8?B?dG5oSWZyRVAwVy8xTDBHNFh6clJtaEFKNjlVeFIrZ3RmaW1lTytXSWZaOUFO?=
 =?utf-8?B?T3AzUG5qN1NRZ2dIdlhjTFlZdkVHZDdnTEJ3UG4rQ0VyRHYvanVHZkd0dEV3?=
 =?utf-8?B?Q0NuT1pEdE55QW5OaTRTY2p1N2ZUbTF1dXVMajhFdWhhdUpJV0diQWtuNWlT?=
 =?utf-8?B?WGR6Z3lkSFJvbVJSdFo5eEc3T0UvSFpXdDQ1aWxmaHA4T0Y0a3FDdzRHN2Qw?=
 =?utf-8?B?dmFhZGhaaTR3YzZSbEpCTnVncncybGNCMDlZMTdOczJncEtZcjJKTm5ESXJ5?=
 =?utf-8?B?cDJsbGdIMkFpcXVaWDVnbHMxbCtXNDFKeUlJK29yb05sbldUY2hQSkZrZTZm?=
 =?utf-8?B?SmJOZVN1bnhZZmlkbUpsaURTdHZtc3RzSE1aYUFRZElkazR1NmtlR0k1T0N0?=
 =?utf-8?B?QVFscU9XTXZqVFFNakFMUWg5blkrWWt5eXMyTE4wc2dsR2hiMUZJUEwzVm53?=
 =?utf-8?B?TVVxdGZvay9oMERSTjRWeW12SCtFRTdWVGlzKzhYbHBnWVN5c3BYYkIvbTJ1?=
 =?utf-8?B?QWpCMGpCRHNaV1NERy94cjkzRHQ4VFRIcEI0RzNpekhvUzBjS09LTzRsMzMv?=
 =?utf-8?B?UUk2ZHVxZTJFZ0RaL1pPdXk0U0cvSmZXcU5YaVRQOTZ6SVFzZ2RMWW9tb1ps?=
 =?utf-8?B?MUZHaVZKTjRyK1VQL1IrVW4rOVlRZlg1MzdOenZLdnc1L1lWc0c4RHVLb3E1?=
 =?utf-8?B?VnI3Q2VrQnJDZTJ5WXFMWEpGM0VBM3FiS2lvaU9VUWQrRW92UWkyOXJvK0lT?=
 =?utf-8?B?WlNTSlN4cXhEVnY1OE5rcjdrYjhQSnJGVE1mWkdJN2ZVaVVYcHUxeWxJOUpR?=
 =?utf-8?B?MkpBVFJzclBNMEFqTjBXVmcrVDBzd05zTGRYV3F1WWdidDEvNEJ4VTMxN0E3?=
 =?utf-8?B?RzE4MFRyYUxySVY3TXh6QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q21mZFhhZ2RqZHl0VHg1Z3loOVhMMTdMT01sN3liQTNWRU1FUHN4bXVnV1Qr?=
 =?utf-8?B?YnFNWXI0S1BYZjJRSkE2Znc3dFdJTkw4TDB4WGJnYUtFVlV3V09ZZzlTWHpN?=
 =?utf-8?B?enpPVUl6TExzNldWRS9mbmc4YVN4OVU4NWhaR3VOYVJrUXZGZXdNSkp1eHRH?=
 =?utf-8?B?aUtQb0l3bERiTzVOU00zVm5TR2pYSE12Q2dFWUJJeGN6RnBmUTcvaHphaHkr?=
 =?utf-8?B?S1hBWG01S1AwV0l4RTRabUNOWTkwVGJqWkU1Wm9TSGs4QUxNamExSE1PSmJu?=
 =?utf-8?B?WWp6NVlPSVM1T1VSdUdQYkQ0SjVFZWFSSW1XUjV1blpTMjlJTjBDYkZEb3F6?=
 =?utf-8?B?WEtrM1NYODdwbThlRGVzaFd5YUtROVBZY0gzRXRkc1dvcVV0alRITENmRE16?=
 =?utf-8?B?amRPU2tiTHZoallKMDN6MkxPMlhJaGZWa1JZcDExMXIrQUhQRVpYOXZYOXdi?=
 =?utf-8?B?SHJXVnlJSjIxRnJQYmVrOVpOaFFjOHU3ejI2QnVYRlFrM1hDekVlSGQ2M0NG?=
 =?utf-8?B?Znl2WFVxV3VxekVzSGlaUnFheDBSOGtVUnppMW9CZmRydmMxMlFJZnNLVnVm?=
 =?utf-8?B?VmFUSGN4TUxuWDROL2d1TGJOQ3hIZXR3VWtrMWJzK3pFL1hYT1cwdkVUUjlm?=
 =?utf-8?B?akNDVlFLa0pOcFNtbTJ0b1hjdjRxaGxhNFcvQW1wZnB1dUJLMkRjTE04bTVM?=
 =?utf-8?B?MitucXhWb3E1cDAxaDFlRkw1LzIvakVJV0xuNklBaGpvalh2SHppRHMrZ2R1?=
 =?utf-8?B?Nkd4QVFxd0hHWVFoa09MS2JxWmtrdlZxMHAycFNwb1MvRDdkdEI4ckNuaWJi?=
 =?utf-8?B?UnlhaXA4ZGVnT1FpbXNaaDJnOW9jTlV6aGI1WkFFQThoRHdyVEoybVJ1dmZp?=
 =?utf-8?B?ck9pVGFrbk9pR2h6R3JoNWkzaVdZOGRMUnp2NjJJYTdZNnpaK2VGYitrSjI1?=
 =?utf-8?B?TlZ6T0wvblFWUm9Lc2JJVWRhVmMxVDRiczdmMkpueTF5N2F6UkM2ZXZ4Kzhj?=
 =?utf-8?B?aVNHZzFZck9qdloyci8xSk5oazlLT0lZS0liOHRFRExQZk8wUGt3Ui8vdERq?=
 =?utf-8?B?ZG9DdFEydVk1cU44czNCeWhSd0VheHYrYlBpcEZHc0lTRzFFWTAyclRNdFp1?=
 =?utf-8?B?VFdPUlN4eGJnWmd4OHRLVGpnQjNLd1htNkNMTWV2Lzh1dXVUa0hBUzZ5Y2hw?=
 =?utf-8?B?c2NiNVJpVkRzSjhMZmpMYzVxT2JlbjVSYTNDb0NqaFlYK3FsRExwamRhZG9h?=
 =?utf-8?B?bUswRzVMYThWM3FCeFdjTkFqQkUzSmx0aElwd3dkVEVMOUV3WTBhc0dlaUtu?=
 =?utf-8?B?cUhxV0ZEOWJEazhRcHVBZkRLUks2QkYxM09zOW9OZGcxMWsrQkRldGhYcjNp?=
 =?utf-8?B?SUE2b2gzS3VuZDFHQWduTEhkd1ZVUEdjNFBMUzBzejhIK3h0dG04VElTWmlh?=
 =?utf-8?B?UFBlSEFWTVFsMVlvRURuUG9kdjVxYTBVL29rNWEwelllZGZlaHhTeUpLR0NX?=
 =?utf-8?B?RzBmcjBuMnBsamZoUDhDeXEydytHaXpVdTEwUS9FSkcwdUQ1dTN0NWJJV1lY?=
 =?utf-8?B?dUx3dFFGYytGTVZtcklZd2YrZTExQUdPbTdrRjBsa211R1hiN2ZDaWpPVjZv?=
 =?utf-8?B?aVRrM1BtSWFveUtPbjF3UU9WZk5KRGUwVlF5RHBuS0xVQks5MmVaNENXZ3kr?=
 =?utf-8?B?ODE3TUFFaUFYS01oUXU0aERnOFBhNTdDM2FGRzRXMTZ0RXA0WHFER2Z2Rjg1?=
 =?utf-8?B?a2hWZVp2bkN4dTFzbmsrUXlCa3dtSi9QMVRlOHdaT1NHVzcwMG1MZ0VkNGZw?=
 =?utf-8?B?S2E2bEpPY1lwTmxnbmNLTUQ3VEpYQm5GTnJnajZ6cHFzZGRxVXdpSzkvWmI1?=
 =?utf-8?B?cW5rYWZRU09hQnV1aUVHeTlQbHFVeTFQbGlkcWpPMy9uQXM5WXJkTGJlZXNH?=
 =?utf-8?B?dWZlb0kxZkk5ejZTcy81M1E2TUUvVHJFZCtVMXlKa1ZiZkMyVkR2VURsbW9Q?=
 =?utf-8?B?ejd6dmsvMUszYWNNVjFkWTNpV0RPVGtEYk9nTjA5Ti80eXUzMVZ1a1MzUjY0?=
 =?utf-8?B?TDNSZTJZTkRPREJ5WDIyeGJKaHdtYlRuaVhsdmVCL3h5S05MU2lGczVkZmNY?=
 =?utf-8?B?dlowdWNyT1ZyMUNTS0ZxaVBCazhCL1F0cG1YOXptdDRiblBkSmNNYmp5bDNO?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MHmKqhuKtyHGDr12W9kUwFCp31F5mNVqOYlqltjnVQI10+VC9hZXH77ZLR3WVvthB4hCplKchaK7YuOYvvynXnTXX+wLQDQffYJdFS1axLVfxNVRdb7GbyjhoHsZMfCWxUWG/RzM1xuQOcJlzRqmorZFXvRYoJqCy35DiLXRoEFoseMfeOrfIZf4JfGau9r5zOba7u3sCqvD4Vg1QtKyRkV4XXVxvSS2we0p1Px5ZbJti1aKUMVF1+Qz+PfAi6yuivr5sStOGd7LknrkFQ7n44Uoh2dXRQHv+/+lAMxTKKSyZTLTd3KfLSb0YRp0tFQcDeovM4pVpn9Tg+2HbAmKCusmC/CSQ8qwBs0pYlPpRszuigaj9W7zVqgBclklF7bmjafVXQlWm5J09TTRq1RfLN/eCv8AsKN8uOnhnLyy4bt3dcr63czHU6oapzfbBMPF2msnFY6rBKmYLgRsPwmbLukTVEWUOt4wHlQxTE5jmkO9vU1ekgM0LHHGd//W130C2l+2QJ9NLdVXiIovqbmHzekiwzldsW8+FX4Vl1MDB8F2UJ2IE/LEeGKXKA+EGlSqnMGaLxPZLWyf2ekUanbYCjeqQ2IQflnKgfgtdkCih8A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb186ec7-8896-4af6-6d1f-08dcbe164716
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 17:10:07.2474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxHwCAeow1NDe7ZuKvjdYaL4qdhGUz7vwpshYbBdC8p3pr82xGhmir7l/pWQxEAx3CE5E2U+eUe7zRI44VHubiMmJSOG6xwNzKm99t95FtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_11,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408160121
X-Proofpoint-ORIG-GUID: MdplCWKJKO_HGMkHC9DBN81qWr-4XKNG
X-Proofpoint-GUID: MdplCWKJKO_HGMkHC9DBN81qWr-4XKNG
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/16/2024 10:43 AM, Peter Xu wrote:
> On Thu, Aug 15, 2024 at 04:54:58PM -0400, Steven Sistare wrote:
>> On 8/13/2024 4:43 PM, Peter Xu wrote:
>>> On Wed, Aug 07, 2024 at 05:04:26PM -0400, Steven Sistare wrote:
>>>> On 7/19/2024 12:28 PM, Peter Xu wrote:
>>>>> On Sun, Jun 30, 2024 at 12:40:29PM -0700, Steve Sistare wrote:
>>>>>> For new cpr modes, ramblock_is_ignored will always be true, because the
>>>>>> memory is preserved in place rather than copied.  However, for an ignored
>>>>>> block, parse_ramblock currently requires that the received address of the
>>>>>> block must match the address of the statically initialized region on the
>>>>>> target.  This fails for a PCI rom block, because the memory region address
>>>>>> is set when the guest writes to a BAR on the source, which does not occur
>>>>>> on the target, causing a "Mismatched GPAs" error during cpr migration.
>>>>>
>>>>> Is this a common fix with/without cpr mode?
>>>>>
>>>>> It looks to me mr->addr (for these ROMs) should only be set in PCI config
>>>>> region updates as you mentioned.  But then I didn't figure out when they're
>>>>> updated on dest in live migration: the ramblock info was sent at the
>>>>> beginning of migration, so it doesn't even have PCI config space migrated;
>>>>> I thought the real mr->addr should be in there.
>>>>>
>>>>> I also failed to understand yet on why the mr->addr check needs to be done
>>>>> by ignore-shared only.  Some explanation would be greatly helpful around
>>>>> this area..
>>>>
>>>> The error_report does not bite for normal migration because migrate_ram_is_ignored()
>>>> is false for the problematic blocks, so the block->mr->addr check is not
>>>> performed.  However, mr->addr is never fixed up in this case, which is a
>>>> quiet potential bug, and this patch fixes that with the "has_addr" check.
>>>>
>>>> For cpr-exec, migrate_ram_is_ignored() is true for all blocks,
>>>> because we do not copy the contents over the migration stream, we preserve the
>>>> memory in place.  So we fall into the block->mr->addr sanity check and fail
>>>> with the original code.
>>>
>>> OK I get your point now.  However this doesn't look right, instead I start
>>> to question why we need to send mr->addr at all..
>>>
>>> As I said previously, AFAIU mr->addr should only be updated when there's
>>> some PCI config space updates so that it moves the MR around in the address
>>> space based on how guest drivers / BIOS (?) set things up.  Now after these
>>> days not looking, and just started to look at this again, I think the only
>>> sane place to do this update is during a post_load().
>>>
>>> And if we start to check some of the memory_region_set_address() users,
>>> that's exactly what happened..
>>>
>>>     - ich9_pm_iospace_update(), update addr for ICH9LPCPMRegs.io, where
>>>       ich9_pm_post_load() also invokes it.
>>>
>>>     - pm_io_space_update(), updates PIIX4PMState.io, where
>>>       vmstate_acpi_post_load() also invokes it.
>>>
>>> I stopped here just looking at the initial two users, it looks all sane to
>>> me that it only got updated there, because the update requires pci config
>>> space being migrated first.
>>>
>>> IOW, I don't think having mismatched mr->addr is wrong at this stage.
>>> Instead, I don't see why we should send mr->addr at all in this case during
>>> as early as SETUP, and I don't see anything justifies the mr->addr needs to
>>> be verified in parse_ramblock() since ignore-shared introduced by Yury in
>>> commit fbd162e629aaf8 in 2019.
>>>
>>> We can't drop mr->addr now when it's on-wire, but I think we should drop
>>> the error report and addr check, instead of this patch.
>>
>> As it turns out, my test case triggers this bug because it sets x-ignore-shared,
>> but x-ignore-shared is not needed for cpr-exec, because migrate_ram_is_ignored
>> is true for all blocks when mode==cpr-exec.  So, the best fix for the GPAs bug
>> for me is to stop setting x-ignore-shared.  I will drop this patch.
>>
>> I agree that post_load is the right place to restore mr->addr, and I don't
>> understand why commit fbd162e629aaf8 added the error report, but I am going
>> to leave it as is.
> 
> Ah, I didn't notice that cpr special cased migrate_ram_is_ignored()..
> 
> Shall we stick with the old check, but always require cpr to rely on
> ignore-shared?
> 
> Then we replace this patch with removing the error_report, probably
> together with not caring about whatever is received at all.. would that be
> cleaner?

migrate_ram_is_ignored() is called in many places and must return true for
cpr-exec/cpr-transfer, independently of migrate_ignore_shared.  That logic
must remain as is.

The cleanest change is no change, just dropping this patch.  I was just confused
when I set x-ignore-shared for the test.

However, if an unsuspecting user sets x-ignore-shared, it will trigger this error,
so perhaps I should delete the error_report.

- Steve

