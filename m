Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4002C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 18:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdZvw-0005kT-T7; Mon, 12 Aug 2024 14:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sdZvu-0005jx-O3
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 14:38:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sdZvr-0007yV-3f
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 14:38:18 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CHXuKN018544;
 Mon, 12 Aug 2024 18:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=U/WBMwz7bMeHYy0QUQqa5BucEa9FcCqNwHLMtI7vfl0=; b=
 nZ0JddKWucTxeHeZ17dlDxBiyVEIo/BpsUuKkMrTCIF2KrS3L4P4NmHVtsbDZpBU
 DWc2sfi7CeiBOGH83lFLD5xH6QyJmdvPxCAVtu+HETvTLx7nPZgDFYXmEZ3wTp5U
 GwFIcY9dlT5JIyzD4hIw5VoezcDKjVCleoaSXVNHTcwkz73GZ20BlCllv8Yoec/Z
 siTKo67uhAW9ii7Nnxb743kKe3ZITHeIHDNyxqLkTglGhE7MN1xrd/h9SaimDUCm
 AkK6apGYZOa61y63iDAdIebAi+HSci9eBnjtlBLXwQx0gRlGt7iIxy0tagnQk1BD
 dXFv9PoYI57em3/Z6zsanA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0393a3u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Aug 2024 18:38:08 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47CHApOh021071; Mon, 12 Aug 2024 18:38:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxne1156-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Aug 2024 18:38:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4PB74khbUYlv248K4PJWNM7Z4lvnYkS4vTV4OY17+m+H9AB9qlnh2m62+3cuTryKJC0qtnPxkk1bo1dEMOWsWvGZZJws9/0SRZjHgGdXqOgVM+oaLcZxHLD6wfiVo9vCbOmlU97Y1fqGqwDC4tes0loLQPNbhBXBtVOCFIirlq7I+jnrxNaX6c73mnSh6b/8Iq/9pmZ4dJGNRK8r4nhFtTQhqi5xMCei79WBp5TMbmlu23NXb+WrsvwMEB9JRYQMVAHcXMvJphMlT5SE05HemzQxx+c3E+iU4noNDtp1W1C9KaKyomBEJHOhHMa8sK24Sp3apWNqhedHUim0f1cdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/WBMwz7bMeHYy0QUQqa5BucEa9FcCqNwHLMtI7vfl0=;
 b=CtfScjSLdR9g+ZgtoQWr5FYj5MFhhq8aSIW2FHVw/4xVZqUGOTHFo3cXM3ph52HNtW7qVkiZVsqZdyVRSV13v1R+ZlHBNCjOz+6tVBVgTrlKb2/DmFoTFkSCtjYKp/KX5Vu3RXfESXgwXrUfiMYjR4TcYfIa7tkbdlQJilRqP9pthXRYS5ImjzRmbzawTTPkT6qhUm5YJZ4lICXwSf+q4NAwC3IwRK6eDyUk7JKrDYQNuS3WPO/edqrVFLCMwtNIW8Wb7Og8DJ/kZuubYAL5CPUa3B5X0xxsA/RaWhyVkBlYAMQHTZi31PSVXHqwlmitOCIX8M9htN2/rHymD30ZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/WBMwz7bMeHYy0QUQqa5BucEa9FcCqNwHLMtI7vfl0=;
 b=LrJsNkFRQgZuFqMyim/2VaU4zWzJYyV+N/wVprxyMOPj3QyTRp+nOaJJ3CBevJdzNKHRwmE9H7cUMWLVGJcif+YGJL/J1lw9qfSTDzBVhUm6rdzFOBHs43bUz9eIL3P3VHlbf/0CA7WKfw/3x+nvDb0yHyrlywA2dPHzZo80vjM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB6975.namprd10.prod.outlook.com (2603:10b6:8:146::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Mon, 12 Aug
 2024 18:38:03 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.012; Mon, 12 Aug 2024
 18:38:03 +0000
Message-ID: <64b8934e-2655-4224-aaf1-e125e6469f87@oracle.com>
Date: Mon, 12 Aug 2024 14:37:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
From: Steven Sistare <steven.sistare@oracle.com>
To: Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
 <88945053-6918-4096-ac55-0ef4b946b241@oracle.com>
 <20240729142932.6667c5b5@imammedo.users.ipa.redhat.com>
 <369f6786-1146-4d5e-a9a5-c0b0b5f45bf7@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <369f6786-1146-4d5e-a9a5-c0b0b5f45bf7@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0169.namprd04.prod.outlook.com
 (2603:10b6:408:eb::24) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d4f8d5-0687-42a1-8cd0-08dcbafde60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVcvSnZzcTVEME9vc01qQ3c2bjVidXMwbjVtakVQVVQrRFliMU93dWRYMnVB?=
 =?utf-8?B?OEZ5a3FXNXhQMlk5eGc4Q0JKNUdlVXo4aTh6NXRqcG5Rd0NyNHc0a3RoZmQ2?=
 =?utf-8?B?N3VGYnl5a1FvMjV4bEI4VVVlWWIwVzFmWEQxVnkyU3Q3eHdhaC9rUTgxdGVD?=
 =?utf-8?B?VkFsZjNSaDlFWkpmZ2ZETHFXTWFWT04rOUthUTNBdjJNckFXMnRRTUpPWUo5?=
 =?utf-8?B?RUloK2dSb3k5MnI0Y3k1L0JldGgwNVNleFZ1OGRYd1pqQk5sV1MrSExlWjBu?=
 =?utf-8?B?Q0t3U2hxSmlxRnFVVlV1UC90Y2pHZUc0NFk1c3NjSzU5TVg3ZDBOSnNxMnR3?=
 =?utf-8?B?VnRURWpWOEdaUGdNaW14SkpaWWUxazhxNlZZZWJMYWZUQVVpLy9hbHJDdlln?=
 =?utf-8?B?bGVpTXFtSldRampjdnJCSTV4MXNXeEpBSmJQMWFSVDFDZnZQZDcrV2NsTWJR?=
 =?utf-8?B?SFJxMUpBSG1EdkJvK0dkZDArWmFxanZNRTFUcmswSjRONzZNZ05HbzFJV3Zp?=
 =?utf-8?B?YmZGbng0c3gyUndVR0UxMUFwd3hCd080VXp5eFFrcUN0UWc3VXN5WnA4a05i?=
 =?utf-8?B?d3dGZ2JZWG42Mk1jR1ljdXdQRzR0dzFVc24zTVZtZFFmVURMQ0hJRmx3WFRt?=
 =?utf-8?B?QUhXMDQ5aUtQMGRlR1NOWWNYeFJ6WHJ0WkpyRTNGQ0JJVlJoNlBFNEQxWk9r?=
 =?utf-8?B?YlRud0tmSFRieFNpYkpJV2t1b1FTYkFkb1ExTkU0cVdCMW9zRjUxd3RHdEFI?=
 =?utf-8?B?K0JmREM4emZRR1BDSTU1emNrNnhDeXF5MkZrekUyTm1PWlpvVVEyTExnMC9x?=
 =?utf-8?B?NUM1SERGVE5hUlkrMXVMV2hhbDZrOXhhdVd3MkpJZm10WDRGREFkL2pTMEYw?=
 =?utf-8?B?bkh2N3RqTk41UGY4a3JlazlPVjlUVW1sMGcvLzR2ODU4UVRvcXhxTDVraWJS?=
 =?utf-8?B?TUJIbEFhVUJjN2lFeVdYM1NSNFVLSG9BL0YvckxTUWc3WkdoY2IvOGtmVnlz?=
 =?utf-8?B?R1NqMGlERThzczlvaXp1SlQvUXgwYXVWaUoxNkQ4NjZkSUM3NTVLUWJMUE9z?=
 =?utf-8?B?ekVIL2t0S1FVZm9UTzQ1WXY4WitvZXVJMnJhUlJCa3VPUkVldER5czlodW1q?=
 =?utf-8?B?NWRrN2pPclQzc00yVHNMaVNXNklHZFd0a2hmcG5RRWRhbWNPUUlFRnAraUNL?=
 =?utf-8?B?am1iY0x1NmtHa1FjWVA3UTg1cXB0SzRiRUVIb2dBa25laEZHdEVNNVFaeklx?=
 =?utf-8?B?OWdPVmNBV000TlZzbnpwZ1dFUVhkS01mS2pYRHFnbjRETHJtK3JIWjJGVHF2?=
 =?utf-8?B?ejRsWkttMVZmMDNycVZCR0h0a3FNSDc2TzBibENDWFpCVjZWeUY4aGNQdXpx?=
 =?utf-8?B?SFBVTHFjSnZrUG9XTlJRUGNld2pBQ0lyazVwaTdVT29rQTNLOTJwbStyeUc2?=
 =?utf-8?B?MGo2OWQwaCtRQldzMVZqSHF2TkYrRGExcjhSWWgrVWEvUUU0ZjR3WTN2bXVE?=
 =?utf-8?B?RGRRck1pdnZaeG9KYS9OWTVPZ2dUV3hCL3o5YUdZV0dCQU1ZNHc3UWx0RjRD?=
 =?utf-8?B?OVVLenNtdmE3OEU5MG41TkZPM2RGd043OE5UdlgrcmxRbkZTK3BlWFN6Y0Jv?=
 =?utf-8?B?L0I1NFc1bVV3VzJuN2V2NFdVT0FpM2xqL0JXWnh6ay9FbHZiQXJFNnJ1aEs4?=
 =?utf-8?B?UmZuMGowUy80ZE1wZklaNVRsUS95UUt3K2UzUWhrTTRFUEdIclFoL2RHSlFl?=
 =?utf-8?Q?35nBKYE6WalHuXZHp4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US9HUW1YcXRYVC9IdmpZdkVMRHlSa1duWW5PVE1ES1VaeFBhLzFBMWxraGE0?=
 =?utf-8?B?ak5Qc1VOTnM5cm5ISGJydndTb3ZGa2pvcjhVbUNUN0VlSFNTZ0dNYndmeHlq?=
 =?utf-8?B?VXpiRml4UkUvYXAvQUI1VGxjWEkrSmJoWnBOVEVVWi9IN2poYm5zbE1uTXpu?=
 =?utf-8?B?UFR6TkVWTlRzVjNYODFkQzFzeXhUdnQ3ZWdvbk9YQzROdlczWFdsOFhKa09W?=
 =?utf-8?B?WWtlSlN5MG5HdzF6cTA0SjRhdmZuRnZ1TnB1d2NsaXBWdzRQYUs3NXJiWDh0?=
 =?utf-8?B?SlBpN2Z3UWFTc1JrMG1ibFRyMjlXZCtXYzdCK01aQzdiSURhMWpBaUhtcm9r?=
 =?utf-8?B?TVlIemFlOXYzdS9VOWZ2MTJKcXVYTi9uVXkzZW92QmdtWFVnUURTN0t1Y3hX?=
 =?utf-8?B?Z2cvK2Jlekx4NWpHMjlpOGhLbndaSnBaZVY5N3VET1QxRTM1S00xcFZCUWc4?=
 =?utf-8?B?TlFESk5NanN5enhYWklReUZyZktLV2pLbSs4R3d4NW1zWHZDZk5JN2dSNnA4?=
 =?utf-8?B?VDJ1ZWdZZHdQcDB1MkdyR2tOcVhTTnI1TE54eGkzSVEvTmlBK2E4YjRGWFZM?=
 =?utf-8?B?NW1QelFVOGY3VzVwQWFSWUkvUEZPZzhPamk3bWJGcXZSZ2tZL1RQY1RRdUNX?=
 =?utf-8?B?c00wZ1VGZUJRc2cySFE5R0VHenhYb3hmVGhCOHNoWnVkT2Nhb0JzZ25zNE0z?=
 =?utf-8?B?TU04dXRIWGlqbERoR3hMQlBXZUdlMFE0RVVXc25vL2Y0ZEsvWCt2ajBRWm81?=
 =?utf-8?B?a3M1Wlg1dTcrQVFxWEpOOHZKcnNoUisvRE5URUpoYlZnZ2ptUFJGZG9wN1Nu?=
 =?utf-8?B?T1g5MTZXNEZJNkNtanNpWFFtVXcvU09TVzRMMm5hS0lyRHZtKzhDRWtRRUEw?=
 =?utf-8?B?ZHM0WTVtYktqZWU0QVVzaTJad2xCYld1UWdMWlUwQ05lNFNQQ0tHQ0MwcEpR?=
 =?utf-8?B?VDYxalNpV0s2Z21PaEd6NmtxdXgwNnYvMUJaaWpDMlg5bnovYUN5a2MyTnlt?=
 =?utf-8?B?OU9GdjJsWG9OVWp2K2JhcTZtdm9PYjQ3SjlLRG1GY251MDFuTUJPOHV3YnRW?=
 =?utf-8?B?Q0x6M2JCeXBDMVFpY0xTMHV5T0ZFMk9SQTBwcFlENDVxMDRhQk5NMkU0WVlB?=
 =?utf-8?B?WkU3bW5melYrdmFSME5hb2tnNjdtRFFaZmtWNzR0US96Y2I3eHBDZ2pmVjEr?=
 =?utf-8?B?ckhPUWZQNGZhc3NJSGdkQk5qT2x1S3M3NktJZVJQN0xsZ0pVZEZLZ0RFZkwv?=
 =?utf-8?B?YWJWR0FXTnBzVUtOQTFxdVFyZ2R5aEN4cmtRcksvbm5KNkxHTkNjYjBIK2ow?=
 =?utf-8?B?WkIrN2tjK3ZveU5SUGdwZUNyZUgzUnFHdkVOUVNocGFmbnNiajlHek1LZXh6?=
 =?utf-8?B?allIT29PQlhpSFZwS2lJV1lOQlJCS3ZwTmFqMlF2dldHbk9uVHhpWTVwaG15?=
 =?utf-8?B?RUxIZGtjVDZlZkYyWFQ3V1VIME1RUGorM0JReG1iRzFLV3ZPZ2hZSHdCejVj?=
 =?utf-8?B?SmZpd3FQMSt2alBIUXF3QThVSDA0NTJNVGVTSkJQMXZWdlkvZ2ZqZi92bjVR?=
 =?utf-8?B?a1kwUlM1aFQ5VjRBUXdySjZrRG1qMDhYWWNqdWVzcXRneGtFLzZmZTAxQ1Bt?=
 =?utf-8?B?WEthOFlEdWhmUHZhV2VEdGdOTCs3Y2NLaUM4MVQ5ZlJqaWNTOTdza3lEMWRk?=
 =?utf-8?B?MFlLa0l5Qis4bEFtTHorT3JDYm9WYXpXTU0wR1YyenFwcjRWSHdIOHliQ0I1?=
 =?utf-8?B?Um45S3dQc3lERzFybE9tQ3RqL1llVG9DS1kydGhCdExKaXNqaVNxYlhmNnNE?=
 =?utf-8?B?dTVCbVNNQU9rN21ObmNDY1QwczdYYzgxNDc4dkl6L2xIcHBsMXoxcDZCS0Zz?=
 =?utf-8?B?dUR2dElqVXBuaS9vVGxSK1VzdWNCT05DYjVMUVgwZy82L0NKTWlBbmJKYXcz?=
 =?utf-8?B?VUdIdVJzQ1ovbDdqb2d3RFVkRlM1VXZYR0R0amNsQ0xLbEhiTytxd2JQZEJw?=
 =?utf-8?B?OFN3V0VIUHFkb3YvZlp2aENKMjkzTkdjYjYyODlqTHdldG82MEk3Z3BQbHox?=
 =?utf-8?B?WXFzR05EYjdXczcwNWswSnplVWwxb3gyd25uUXJJbTJXeEhDcmt5WlA2VUs1?=
 =?utf-8?B?QUxab2IzQkF6UlJ1Z1NVbUF6MHEyM05vdjlIQ2xtUmFjbDBPQmRmR3NoVno4?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pz+Uijac0go0ZuontvG5B/Ik7/5cllRieGzn7xF9j0UCWNxRXOsDxAmmjeW8KOQ1Rf7XUuUK7Bt81wyVakScZyGkAO5UfFXtLl0pa+qoe1nGzzg3nxu5sAOS0J06dzh39E9wMvo6qcKFKUaf3UWKkMOEWZqZAqDzG35W5MmkL59sdS1ERZx1xWviZCGtVOA/6ao2MQEYmF/1q5F+nK8Q2Wwsr432x8zmcwYLPhr7OCZpmbg1B88C8Xt64vtulSx46QdpuiI4X9li/AQjnakkq2ZJYWjR5tHLLBaubOkJfwgRQxvr7ntW8MWbnt7odQHVlg9WrlBtGopKG9Dddfwt/SsBWwxqR45sKfc54r632aUIa61s4B64oLBDti7ZtQo7Ji8LNjCpjdIBbl/wOI0aiomwoU0Qs8P36So/nbppFs/O93+jWta1DduriQJi5Kw7lewwpMEzPNFmhveGDPBHo1gMA56sHgARuR8jBVjVRSAFUBEcUYHGp6X6w90XUATO+HQvqToRn+4XZs8+7Tyevb/2DEctKthqPNCUye6edouDQcJkUv+aXFbQayg0yEiZanDHtsVsIqYOBaEqNb+V9cbyW2z2NTvTyAScmFgs6a8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d4f8d5-0687-42a1-8cd0-08dcbafde60d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 18:38:02.9835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3r4lQe/jvdMUZOuyHAhb7KLYeLUmgzmT96GLDkZuamDHOHE3SFqvD2GKQF6CwkQwYjDPav/5U8NAj7jZbafhPHMitzD0obzpH6oDl7i8RM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408120138
X-Proofpoint-ORIG-GUID: qxa-Flaki1SnwHJ_bzzGcGpfuMEU6Yp4
X-Proofpoint-GUID: qxa-Flaki1SnwHJ_bzzGcGpfuMEU6Yp4
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 8/8/2024 2:32 PM, Steven Sistare wrote:
> On 7/29/2024 8:29 AM, Igor Mammedov wrote:
>> On Sat, 20 Jul 2024 16:28:25 -0400
>> Steven Sistare <steven.sistare@oracle.com> wrote:
>>
>>> On 7/16/2024 5:19 AM, Igor Mammedov wrote:
>>>> On Sun, 30 Jun 2024 12:40:24 -0700
>>>> Steve Sistare <steven.sistare@oracle.com> wrote:
>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>> on the value of the anon-alloc machine property.  This affects
>>>>> memory-backend-ram objects, guest RAM created with the global -m option
>>>>> but without an associated memory-backend object and without the -mem-path
>>>>> option
>>>> nowadays, all machines were converted to use memory backend for VM RAM.
>>>> so -m option implicitly creates memory-backend object,
>>>> which will be either MEMORY_BACKEND_FILE if -mem-path present
>>>> or MEMORY_BACKEND_RAM otherwise.
>>>
>>> Yes.  I dropped an an important adjective, "implicit".
>>>
>>>     "guest RAM created with the global -m option but without an explicit associated
>>>     memory-backend object and without the -mem-path option"
>>>
>>>>> To access the same memory in the old and new QEMU processes, the memory
>>>>> must be mapped shared.  Therefore, the implementation always sets
>>>>> RAM_SHARED if alloc-anon=memfd, except for memory-backend-ram, where the
>>>>> user must explicitly specify the share option.  In lieu of defining a new
>>>> so statement at the top that memory-backend-ram is affected is not
>>>> really valid?
>>>
>>> memory-backend-ram is affected by alloc-anon.  But in addition, the user must
>>> explicitly add the "share" option.  I don't implicitly set share in this case,
>>> because I would be overriding the user's specification of the memory object's property,
>>> which would be private if omitted.
>>
>> instead of touching implicit RAM (-m), it would be better to error out
>> and ask user to provide properly configured memory-backend explicitly.
>>
>>>
>>>>> RAM flag, at the lowest level the implementation uses RAM_SHARED with fd=-1
>>>>> as the condition for calling memfd_create.
>>>>
>>>> In general I do dislike adding yet another option that will affect
>>>> guest RAM allocation (memory-backends  should be sufficient).
>>>>
>>>> However I do see that you need memfd for device memory (vram, roms, ...).
>>>> Can we just use memfd/shared unconditionally for those and
>>>> avoid introducing a new confusing option?
>>>
>>> The Linux kernel has different tunables for backing memfd's with huge pages, so we
>>> could hurt performance if we unconditionally change to memfd.  The user should have
>>> a choice for any segment that is large enough for huge pages to improve performance,
>>> which potentially is any memory-backend-object.  The non memory-backend objects are
>>> small, and it would be OK to use memfd unconditionally for them.
> 
> Thanks everyone for your feedback.  The common theme is that you dislike that the
> new option modifies the allocation of memory-backend-objects.  OK, accepted.  I propose
> to remove that interaction, and document in the QAPI which backends work for CPR.
> Specifically, memory-backend-memfd or memory-backend-file object is required,
> with share=on (which is the default for memory-backend-memfd).  CPR will be blocked
> otherwise.  The legacy -m option without an explicit memory-backend-object will not
> support CPR.
> 
> Non memory-backend-objects (ramblocks not described on the qemu command line) will always
> be allocated using memfd_create (on Linux only).  The alloc-anon option is deleted.
> The logic in ram_block_add becomes:
> 
>      if (!new_block->host) {
>          if (xen_enabled()) {
>              ...
>          } else if (!object_dynamic_cast(new_block->mr->parent_obj.parent,
>                                          TYPE_MEMORY_BACKEND)) {
>              qemu_memfd_create()
>          } else {
>              qemu_anon_ram_alloc()
>          }
> 
> Is that acceptable to everyone?  Igor, Peter, Daniel?

In a simple test here are the NON-memory-backend-object ramblocks which
are allocated with memfd_create in my new proposal:

   memfd_create system.flash0 3653632 @ 0x7fffe1000000 2 rw
   memfd_create system.flash1 540672 @ 0x7fffe0c00000 2 rw
   memfd_create pc.rom 131072 @ 0x7fffe0800000 2 rw
   memfd_create vga.vram 16777216 @ 0x7fffcac00000 2 rw
   memfd_create vga.rom 65536 @ 0x7fffe0400000 2 rw
   memfd_create /rom@etc/acpi/tables 2097152 @ 0x7fffca400000 6 rw
   memfd_create /rom@etc/table-loader 65536 @ 0x7fffca000000 6 rw
   memfd_create /rom@etc/acpi/rsdp 4096 @ 0x7fffc9c00000 6 rw

Of those, only a subset are mapped for DMA, per the existing QEMU logic,
no changes from me:

   dma_map: pc.rom 131072 @ 0x7fffe0800000 ro
   dma_map: vga.vram 16777216 @ 0x7fffcac00000 rw
   dma_map: vga.rom 65536 @ 0x7fffe0400000 ro
   dma_map: 0000:3a:10.0 BAR 0 mmaps[0] 16384 @ 0x7ffff7fef000 rw
   dma_map: 0000:3a:10.0 BAR 3 mmaps[0] 12288 @ 0x7ffff7fec000 rw

system.flash0 is excluded by the vfio listener because it is a rom_device.
The rom@etc blocks are excluded because their MemoryRegions are not added to
any container region, so the flatmem traversal of the AS used by the listener
does not see them.

The BARs should not be mapped IMO, and I propose excluding them in the
iommufd series:
   https://lore.kernel.org/qemu-devel/1721502937-87102-3-git-send-email-steven.sistare@oracle.com/

Note that the old-QEMU contents of all ramblocks must be preserved, just like
in live migration.  Live migration copies the contents in the stream.  Live update
preserves the contents in place by preserving the memfd.  Thus memfd serves
two purposes: preserving old contents, and preserving DMA mapped pinned pages.

- Steve


