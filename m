Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F331BCAC5B9
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 20:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1skJ-0007Y8-3q; Thu, 25 Sep 2025 16:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v1skF-0007W8-Br
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 16:39:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v1sk5-0000cD-9u
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 16:39:15 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PKF3X5017053;
 Thu, 25 Sep 2025 20:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=qcLrHfWLZ+KjMr08hg46ZZvGhHatsi7YiywTCR/tZuk=; b=
 AEM5SDpp3HqdxQhdegJ2GFgbq6YHz5dcakhu39yVSjMxVYM6vqhDYrafD6Y7vGaT
 ZZxBpTK049Jzcz7Io/zlUnRm9Msg58sFkMjLjnq+jlIxy8Z29dBWluCjtCLDzvxR
 eI3atyfRzR5zjru06JkB5/bN15hf9fG6U+wZ1sXkI3lIUZRnv5VvZR4/FEpM+bMa
 KHEYdILAGlRBv5kznY04/snyZOgqj64ozuBL1Hfw1yadaE7IOg2GVoPFve10T4dH
 LmW4zhTfCF0HKJzfjC+8kQGhjxfZe/pFfCczGm7Iue8TNwqURx/PzQVTtlrCg3Fa
 Z+dnQbog7+92pFTye48Dzw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49dckm01jm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 20:38:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58PKSRHF011436; Thu, 25 Sep 2025 20:38:55 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49dawr4j91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 20:38:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubsrHXWbY75Jdzm4dOkZPoHSKDujY5H2S6UccHwJRxbVrDV5gzkfKdmq/BElScKu5F1gnUq0o80w7tde6HeooFLI8Z3FgcZGG545mnmV0mTyMzBbvCFPXt/Rgiyuc2IpfTnbqgLnRXEH0Jw+wxqYZuZH/2WIJqckDzY0Oe6Nwr56f8a204F8CJtt7UAxU0t8WBpjVx9G45+W3tvZiokklkDe4SNYBqlteIxxy/uKGSuuIgq286MQbezsS7QGHh3EldJ0TIaYQT065QX4OVQFfi5wWmzDG4Y9Cei5mJ5WeRs9ctsIl87cmWQYGYTDQihg0f7PKeQpb3L5Mvjbi9JA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcLrHfWLZ+KjMr08hg46ZZvGhHatsi7YiywTCR/tZuk=;
 b=T4T/LXxlGVqFbiFLEyHlINwxjjYNvHN7voTNj73UXCjSJIYm1R9TZegeAwdVy5C3EjasRK2wGk6yjwebfbOzCdx9LQ3U0G/xM0QviNXPeskNNWRWKk+G/xer4623WDKdkX6uHfEEDhpF3DaTbmqiUwt3rfgWM0DSKSq4sudzZUOB9avtngFSoOKfzyDUt4Pb/3N3HX7kfZQDRNIgfPz8FsoqIPhoiwCBEI1H49WijQTUPqUb+mRIHQomwoouYiQhAX9lKAvhYVqBZnveTJuuCrxX752Pk/ioWLy4EJdbpJhIouSJ8/xQySQsztdhA2IhYeslPeVL9VPodoIZ5jB/uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcLrHfWLZ+KjMr08hg46ZZvGhHatsi7YiywTCR/tZuk=;
 b=D2YUcbhM804j1p6VoRhw7kt8DIXqudxwTMusF3qCgP5CeoqzCCBQkXgJoSlItxFgIpAFdnGtNSHPryRAp2mskknwVRywbLjTx5bFWvGhrT1LKqTKp1XL4SidVzdTuWhTVWrVAC64XCSSedmPqg1LkaYSC372bSkzSYdk90jTz70=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB6135.namprd10.prod.outlook.com (2603:10b6:8:b6::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9; Thu, 25 Sep 2025 20:38:52 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 20:38:52 +0000
Message-ID: <9c4c18a1-412b-41fa-b8da-7918d8620c3b@oracle.com>
Date: Thu, 25 Sep 2025 16:38:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 5/8] migration: cpr-exec save and load
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <1758548985-354793-6-git-send-email-steven.sistare@oracle.com>
 <15399e70-fa4b-4792-9881-9dec59f0c832@redhat.com>
 <e8766c16-5f8e-4b3d-8808-42158d28b549@oracle.com>
 <6d5b95e4-1d50-4b70-8d40-9031f3735d56@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <6d5b95e4-1d50-4b70-8d40-9031f3735d56@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1f7d80-c8e5-44a3-d819-08ddfc7389a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ellCd3UrcUVLR09VeFdDQnk4eVozV0ZUbkc3bmJXSkd5SzQ3LzlGYU9HZkNw?=
 =?utf-8?B?Nkg2Y0lVSERMbXUwMEVwUlFxaVlmUU5UdVVkTmdST1FKUTN0ellkRG9KeHFm?=
 =?utf-8?B?YjQ1UDZtZGQyc2NMOWs3MHM3U1dsRER2Q1QxL0FzVDRybVA2RnJjMnhmZWRQ?=
 =?utf-8?B?cG1yT0xEdm8vVTNJTWtzSUdUTitWV2ZnKzd6V3A4N29OeitMYmN4cmFxWG95?=
 =?utf-8?B?RVJRUDZtWnFKeGh6bWdMekNOZGdVdmwzK2FyUGFONEZkR1pxYzFCc21QYzd2?=
 =?utf-8?B?WGNtbjBpNHhaamdkTE9kVm5JcmM0djlTOVFYUCs3bEJtQ1N2aEdIbDVEZ3cx?=
 =?utf-8?B?N0tCcVNUN2NrQnZERXpjUStMRUpxWHRvS1djb1JEeGFhSkxjRUlFN1ppRVNX?=
 =?utf-8?B?a0VSUkUxdm1YQzFGdkhLRHpvaTVoZjFTL0g4TGNoN0E0U2txVENDOWh5dnZM?=
 =?utf-8?B?bnlIZy9jNzhiOU1OSkorQ1E2UDU1NEhhOTZTdk85U1JtYnMxNG5ReVVPa2RP?=
 =?utf-8?B?RCtLeUlsMHR3N0M4alNVNDhHZEp5L3dhZkFMQ2NGdnNTalNlQmlEVE5La3dv?=
 =?utf-8?B?ek5Kd2FpZTZmeDRmVjFma1JiRVlaU3VQbHMzNkJlMy9EcWtwQ2xwdmdHMm1I?=
 =?utf-8?B?N2g3cmVHOU1JTnJ0Q25QamRQdngvY0hYV25nR1Y1ZVozWWw2N0NRMGkvdjlT?=
 =?utf-8?B?MWtLN2lLTzJqazk2Nmg3cWt0YzRaeVpSaWF3VmtKRzI3MjhHdEhuYVBpaCtJ?=
 =?utf-8?B?cVdocnNhb00vcGtrR0d0RVBnQ2lJQjFwSWEzRG1sRFBJZlp5Ulo0MjVXVHg4?=
 =?utf-8?B?dzNFRTZ1MjVyVldDaVVwd3NiOFBvSVZVdmxrS0VZTDBtalpGWWlPV3VnUmRz?=
 =?utf-8?B?TlMraENpZjhjdEJQTStxMENSYUFTWHhjdmFYSlgreGhrYVRFNFRxUEpWRkE2?=
 =?utf-8?B?OHY0cDNiNmhuNWdIa3J2Z0RNK2NUampSNEFyNDdjOVdGZUVudjd3TzB2MHZF?=
 =?utf-8?B?Mk1QaVVqZS8rRitZeWx3elVUekhNc00zd0VDbG9PRG0xR2RGWDV0NnBEZm9M?=
 =?utf-8?B?N0xvL1N0ajhOcWdMeWtidnE1d1pXZTZEbEJIWXRSQ1M4R3VHTzFhVitXb3Bs?=
 =?utf-8?B?WDMxSlcwRHJqMUZmVHcrRjNkU043Wk5ISGFCb1dYNHdSUFh6a3dlQnpJUEJq?=
 =?utf-8?B?ZzJUL24vc0lJM1c4Q2lqY2pRdDduVUtqRzJKN2Q4azNzMU9qdFZDZURLR01U?=
 =?utf-8?B?L0tsSW44ajFEVDNsVEZCbm4zdEdyQXJwNkN1anF4VVU0VS9yVVRwL0Y3NzVV?=
 =?utf-8?B?UDM1M3Q1MXN0UjdHSld0a3hGSThoc056VHVPZndMTUpmWmJQUm80ZDlLNHJG?=
 =?utf-8?B?N2dXNUJqdW04YzJ3UlloTmZIYUZqdUJOd2RkUnRHaFJvVnpvdUtsNHlRUDZQ?=
 =?utf-8?B?Z2x3b2c2cU9OWkJWaFNvVFNwVzAvcE84MlBRNzdHZVVINWwwWVBFc3ZtOXJl?=
 =?utf-8?B?U0pDSllrZENjU05xRWJES0l3Q21HTGFKSzZoVmM3NG5KU2QrU2liWFN0cHdL?=
 =?utf-8?B?QkpqMnVpNFgxYVVXM296RkpYRjRERXIyaGo5eEdCU0x0MVhRWFlVWkY2TTFJ?=
 =?utf-8?B?WEpwc3BIaFU3V21aM0REVWJPZTZnaHYzN01wbkhzempCTU1sbUdWVzdvb1kr?=
 =?utf-8?B?elRVQWh3aklpUnRvdEdTOThSMWVDRDgwYm1tenpjUTFsN0ZwakJMeVFRbDNQ?=
 =?utf-8?B?ckNxWGUxZzFRcnV5VFZTMHBzSklXUU04NlhtTDFxbDZ5dDd2STFWRy9oU0dU?=
 =?utf-8?B?QjJ0SXBXY1pGRHJtOFpXUmdvSGV1SG1FU2ZlbVZiREZEUEk4N1dsMSs3S1NH?=
 =?utf-8?B?MTNzbXNET0dMQ2l4WVdCZHBGTFIva1pqMjFidDBsaVFrVmRJdjZPT09UcDZh?=
 =?utf-8?Q?TDl+hpJEi9n+S34sKmUcRk95L5bnhsfy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU5zRE9YU0YvSU41YzhkMkJmQ0t1THkyeUphenhRZWR1eE45N3E4V09WWjAr?=
 =?utf-8?B?UE5mb1FuUGUxZm94bFdCOHhJczZNdkNMVlUrTTVsWlYxZHdIQlBrVlVzdVA5?=
 =?utf-8?B?N2JXb0xWb1RyeTFtMmNHK1lwQzZvbzNqU1NBMHBkdFBOcjNFSWVocWxlVnhZ?=
 =?utf-8?B?WnBJWFR1TkZLSHE4ZmlNaTVaTlA0MEVIRFg2eXZoVDNkd1JBUmgwR1RTcXp5?=
 =?utf-8?B?Vi9jUElwdEd6Z29VMXg5ckhsVTYrVW9KR2REVVkxcEg5NnNlQWYrQWdYclZ1?=
 =?utf-8?B?cDNCSEcwRERTWVk1K1Fab3l0Y291RzVIZ0xuQ0NTSkF4dldteXVtem1SMmVL?=
 =?utf-8?B?L25VMFpJaEsxZGVhemNDUGRObnJPZzVFL3VlcUxhZ0d4Y05pbys4d1pjc2NC?=
 =?utf-8?B?NU42L2FEeVREUWQ3UDJZR0hYWTBudGw1RmhnZnB0MS9NUHVmY1FOZWZLSXN0?=
 =?utf-8?B?QWFteHVINTJ1NWJyY1FWQ2gxMTdNQysvUmJmbC9nS2czQkhnM2ZaTGh4N2Iw?=
 =?utf-8?B?N09JK2ZneDg4d3U5R0FXU0R3OG5pNTllVUcwcG1oZFdaTmdCYkVrdUMzMjNn?=
 =?utf-8?B?amIrcldNK0k0NzR5L0pZcVBtUXJkVmRyQWdPSE5CYVp2Q1NsRCtsMVc2NXpp?=
 =?utf-8?B?L2ZQZ2FEZkNINjRGQnpieWlXSExVZllDVlB6SjdWUEU4N21XdXk5WlZMd0dj?=
 =?utf-8?B?bFZ6b3BxOG5hS3gvaUE4SXVaRFB4alRkRlZ3VGt4RHRVallZM21tME5FRG1S?=
 =?utf-8?B?UlhlYXpFb2dwU0RsS0JhQTRxSjU0OWE0NUc1OTJYWGErb3cxVkdMMkE2ZWJk?=
 =?utf-8?B?N1NLTDhpOGJvQ2VjQXhaNERISGxsL1VVdHRhem1Tb3RZTnh3M1MzSlM0aW1K?=
 =?utf-8?B?T1FCV21XN1FQTFFPUFRwTE5ZaDlKd3RXc0Nwd0lsWGpPR0RZcFZRQzZnakNi?=
 =?utf-8?B?NWE5akpmZ0UzdWljTUxjR3MyazlYbzJaa0RxNVZZMnpSSnRqREZaV3hUMERj?=
 =?utf-8?B?THJWNWJVcGNRRmtidXBsNmxQWjhLdGhzamJKRHRlcDBQcTdjdURMZDVkNGww?=
 =?utf-8?B?MjVrTzlUN0ZJTFdQckpCUHBCTVZwRis2djJRZGRFZUovcUpuMG9MSHYvQnJa?=
 =?utf-8?B?bGRaV0N2VEpzSHdIeTkveXhZendOS3Z6Tm82T0krWUhyVlY2Q2pnVSs3WU1z?=
 =?utf-8?B?ekpTQVpNdzhVcDFDczlFR1lpZkI0MlB0MStONnBxWTFyOUxacXVTOWY3U1Ny?=
 =?utf-8?B?TXFqOTNzcVduWHpQWnRXbW9TQi9oNnYyWE1lT2xiUnVrUlBuS0xUR2h3NmFE?=
 =?utf-8?B?cmsvZ3cwSFBhaWRwTWliRGMyY25Bb1FYcG5LME9jN3pXMHpWVkRlZWNWODhm?=
 =?utf-8?B?VVRLNXRURU91M200M1U2NGFzeHY4RktKTzlGb1FNeVJiSjRDVGNDL1lvV0F4?=
 =?utf-8?B?Z3kwTlFKTUswQ0NYK09MSUVSU2xiVnBHSU1vdHV0L0pOZG1ONitXVUkrcTNu?=
 =?utf-8?B?NUFxdWt0NEt3T2UwK3lPK2pOS1RCcC9sbG1jeTVia05Wbk1yN1BDNkxIWFNi?=
 =?utf-8?B?d0I2YjhEdndnOEVDcUdzN2pqbm1waERDNWZnVU0vK1lTYTM1S05zMW44Yy9x?=
 =?utf-8?B?WVVlUU5xR3QwbTVyeFkyQkZKKzEyM3M0eHNFY045S211ZWRSZjNMOUtMVFBZ?=
 =?utf-8?B?RlFTakFuQmJyaG1lbUt0SzFXait0K1lkbkpxUTJmejJiaGVlekVaTjFIdlkv?=
 =?utf-8?B?UGp1Y29aUXgrWTViVjZxcmdiUVVzeXl2SjZPeXliTEdpYW5FUDFIYnVBdUNk?=
 =?utf-8?B?YzZXWFhsekNNb3BqOHZEa3FiS0dxSHNJQmczaFNEN2hlc0JjUmRTbjlwdU1G?=
 =?utf-8?B?SFRDQXRWS0tWSktuMUdCYmJ3b1lTUEI1dlh1cnVtYjZrOVl1ZEJLMXh3dzlh?=
 =?utf-8?B?YktrY2pLQ1JtTU9FZzg2R1RIaktMZ2tlRFNxVFRpOVdzY0pIYUd1NDlmZGx5?=
 =?utf-8?B?TGVFeUxlb1U2dTZSR1JTYWIwYkdWaFB3STZIR1BjODZTRVo3WWlDWkFHOEVX?=
 =?utf-8?B?VXBOUFFtdEtwMDNMajZpUkRyUmFGYWZCQkdlYmFsWHNrQmRTS0dxUkE1K2Vo?=
 =?utf-8?B?ajlXczNIbmtQanYxeC9LV2x1RWcxaVZuSnhhU3Y2aFRFanI2Um8vVjhtTzF5?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fCziKJLrOoDci93prqFJD1q2NwMuXnGrQLKj964AEPk3CqSVGhCSsjDrr6N3oabMslidHoJq91pf4jK8og6B/1ZbzCG+3tLNDALw81pk66mX96dzBkJMBu+WuYH4JQjVfaBkQfTZJRVUJ/zm/sBX4JX8r/GPnR3/nMUmqNAzHxhIMRMDRKrG9UK5yWYODISfiGxjCfVeV+xgr/FxWkSHrCjLYhBjh62E0PKkvrbbwk1Qw0XDkfescEtbS4V+sfyKnf6SLtAAvJrfF5O5GlScyDamNOOA5uoO4UY/c5zFZmW2ef9oovxyz0Ki3YOMdZUwcEfhmsfD587UJOxpLD4xu2N4WswEukiEYRNVOjsqkXpo6rX1H8Odj/AGh7gBZjrdeBU+RW+YRZTl7ZUb/No+Sz0vtg430tGDmrtSHRYiJyWiT72eUgICni+ioptrke8/mYsgm/0088fXv2phZKBpJnfUb3zlGoPROEWdbklsSqOPkPsHlkQC+49kMboz5lTl2BGwoJOdrml8swV2oWpQsCjFOk9VpMFe9H+mSODIRdaNgV4x0i0gWf8IKOObe4/1EFhrgtYUo8H0XT9/TkgAt6qC2C1QFzW6I6NJwTGZc2Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1f7d80-c8e5-44a3-d819-08ddfc7389a5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 20:38:52.1233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ccgwds4x4bWjtGiSN3qTt92aErGfnZRg9QGqpnw1jJkoPZcD8RjFU1rlZlPQR47BC0AkftVcpN4VnwKsCZbao5Db3TN0XgbS082gzdOCYa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509250190
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE4NyBTYWx0ZWRfX0Rz8sx95OwWt
 bxVDAnkLF8wKopoYFUQmLTSe1xY/WcL3uegYuAuIFYqrsWGe5qeU4SwupqvYH0MVYYEDhJSXts+
 1VS8NJDLRWvFphOFZC9Q+PPSdtftrzODerknPbPaKZktaQ/+SZiCLPgtqBx6C3Th6IotEb9Foo9
 Ahp3nsNQD/qBRabZuqmXjNtqNQrgUG3aIBUAdz5MghgnyQRDCcQmVxyV0H7tBjFNO1WJ2qX6NUe
 18+YITy3Tr3OlwKNA19PFPMER0OuvzHDb1ShO3twBsdAu4zKnZ8qt1hckR5s7czwrEy7p6eIv9O
 jYvoJ6Tlc73w+BxhHjdb/RrQOTHsyOiABtpkYc/5zuIbmY9Dae+5LJsr2bpMdWtAhAer6wA5fw2
 WFy9fKwyw664NYpg+kayg1rXSO/p/iGYWNaj5o1DTU/AKYvl0cY=
X-Proofpoint-ORIG-GUID: 8KGUp7yPgrul7LWb7QFQB34xSlxkTdfR
X-Proofpoint-GUID: 8KGUp7yPgrul7LWb7QFQB34xSlxkTdfR
X-Authority-Analysis: v=2.4 cv=A7lh/qWG c=1 sm=1 tr=0 ts=68d5a860 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=MegqYqQa9HSCmuSW5RgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12089
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 9/25/2025 3:11 AM, Cédric Le Goater wrote:
> On 9/24/25 20:16, Steven Sistare wrote:
>> On 9/22/2025 12:00 PM, Cédric Le Goater wrote:
>>> On 9/22/25 15:49, Steve Sistare wrote:
>>>> To preserve CPR state across exec, create a QEMUFile based on a memfd, and
>>>> keep the memfd open across exec.  Save the value of the memfd in an
>>>> environment variable so post-exec QEMU can find it.
>>>
>>> Couldn't we preserve some memory to hand off to QEMU ? Like firmwares
>>> An environment variable is a limited method.
>>
>> There is no upside in making this more complicated.  We only need to
>> pass one tidbit of information -- the file descriptor number of the memfd
>> that contains all other information.
> 
> Please adjust the build for windows, memfd is Linux only.

Will do, thanks.  I will call qemu_memfd_create, which is defined for posix
and windows but returns error for the latter, instead of memfd_create.

- Steve

>>> That's a short term hack right ? it's not even documented. 
>>
>> It is an implementation detail, known only to the matched saving
>> and loading functions inside qemu.  No one else needs to know, so
>> no documentation.
> 
> ok. Fair enough.
> 
> Thanks,
> 
> C.
> 
> 
>>
>> - Steve
>>
>>> I am sure
>>> you something else in mind.
>>>
>>>> These new functions are called in a subsequent patch.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>   include/migration/cpr.h |  5 +++
>>>>   migration/cpr-exec.c    | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>   migration/meson.build   |  1 +
>>>>   3 files changed, 100 insertions(+)
>>>>   create mode 100644 migration/cpr-exec.c
>>>>
>>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>>> index 2b074d7..b84389f 100644
>>>> --- a/include/migration/cpr.h
>>>> +++ b/include/migration/cpr.h
>>>> @@ -53,4 +53,9 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
>>>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>>>>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>>>> +QEMUFile *cpr_exec_output(Error **errp);
>>>> +QEMUFile *cpr_exec_input(Error **errp);
>>>> +void cpr_exec_persist_state(QEMUFile *f);
>>>> +bool cpr_exec_has_state(void);
>>>> +void cpr_exec_unpersist_state(void);
>>>>   #endif
>>>> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
>>>> new file mode 100644
>>>> index 0000000..2c32e9c
>>>> --- /dev/null
>>>> +++ b/migration/cpr-exec.c
>>>> @@ -0,0 +1,94 @@
>>>> +/*
>>>> + * Copyright (c) 2021-2025 Oracle and/or its affiliates.
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "qemu/cutils.h"
>>>> +#include "qemu/memfd.h"
>>>> +#include "qapi/error.h"
>>>> +#include "io/channel-file.h"
>>>> +#include "io/channel-socket.h"
>>>> +#include "migration/cpr.h"
>>>> +#include "migration/qemu-file.h"
>>>> +#include "migration/misc.h"
>>>> +#include "migration/vmstate.h"
>>>> +#include "system/runstate.h"
>>>> +
>>>> +#define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
>>>> +
>>>> +static QEMUFile *qemu_file_new_fd_input(int fd, const char *name)
>>>> +{
>>>> +    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
>>>> +    QIOChannel *ioc = QIO_CHANNEL(fioc);
>>>> +    qio_channel_set_name(ioc, name);
>>>> +    return qemu_file_new_input(ioc);
>>>> +}
>>>> +
>>>> +static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
>>>> +{
>>>> +    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
>>>> +    QIOChannel *ioc = QIO_CHANNEL(fioc);
>>>> +    qio_channel_set_name(ioc, name);
>>>> +    return qemu_file_new_output(ioc);
>>>> +}
>>>> +
>>>> +void cpr_exec_persist_state(QEMUFile *f)
>>>> +{
>>>> +    QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
>>>> +    int mfd = dup(fioc->fd);
>>>> +    char val[16];
>>>> +
>>>> +    /* Remember mfd in environment for post-exec load */
>>>> +    qemu_clear_cloexec(mfd);
>>>> +    snprintf(val, sizeof(val), "%d", mfd);
>>>> +    g_setenv(CPR_EXEC_STATE_NAME, val, 1);
>>>> +}
>>>> +
>>>> +static int cpr_exec_find_state(void)
>>>> +{
>>>> +    const char *val = g_getenv(CPR_EXEC_STATE_NAME);
>>>> +    int mfd;
>>>> +
>>>> +    assert(val);
>>>> +    g_unsetenv(CPR_EXEC_STATE_NAME);
>>>> +    assert(!qemu_strtoi(val, NULL, 10, &mfd));
>>>> +    return mfd;
>>>> +}
>>>> +
>>>> +bool cpr_exec_has_state(void)
>>>> +{
>>>> +    return g_getenv(CPR_EXEC_STATE_NAME) != NULL;
>>>> +}
>>>> +
>>>> +void cpr_exec_unpersist_state(void)
>>>> +{
>>>> +    int mfd;
>>>> +    const char *val = g_getenv(CPR_EXEC_STATE_NAME);
>>>> +
>>>> +    g_unsetenv(CPR_EXEC_STATE_NAME);
>>>> +    assert(val);
>>>> +    assert(!qemu_strtoi(val, NULL, 10, &mfd));
>>>> +    close(mfd);
>>>> +}
>>>> +
>>>> +QEMUFile *cpr_exec_output(Error **errp)
>>>> +{
>>>> +    int mfd = memfd_create(CPR_EXEC_STATE_NAME, 0);
>>>
>>> The build should be adjusted for Linux only.
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>>
>>>> +
>>>> +    if (mfd < 0) {
>>>> +        error_setg_errno(errp, errno, "memfd_create failed");
>>>> +        return NULL;
>>>> +    }
>>>> +
>>>> +    return qemu_file_new_fd_output(mfd, CPR_EXEC_STATE_NAME);
>>>> +}
>>>> +
>>>> +QEMUFile *cpr_exec_input(Error **errp)
>>>> +{
>>>> +    int mfd = cpr_exec_find_state();
>>>> +
>>>> +    lseek(mfd, 0, SEEK_SET);
>>>> +    return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
>>>> +}
>>>> diff --git a/migration/meson.build b/migration/meson.build
>>>> index 0f71544..16909d5 100644
>>>> --- a/migration/meson.build
>>>> +++ b/migration/meson.build
>>>> @@ -16,6 +16,7 @@ system_ss.add(files(
>>>>     'channel-block.c',
>>>>     'cpr.c',
>>>>     'cpr-transfer.c',
>>>> +  'cpr-exec.c',
>>>>     'cpu-throttle.c',
>>>>     'dirtyrate.c',
>>>>     'exec.c',
>>>
>>
> 


