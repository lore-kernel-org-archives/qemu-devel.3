Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C14D3B7F2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 14:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSc8m-0004bj-2k; Mon, 08 Dec 2025 09:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1vSc8h-0004b9-QN
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 09:23:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1vSc8b-0006tI-RT
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 09:22:59 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B8E2TcX2641207; Mon, 8 Dec 2025 14:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=au0b394Nq4FQbhsMxw
 MN958wnk9NmKd1zi6cqoRGquU=; b=BohUFGc7muuxd84HzpZsExVCNCr9pJRXnZ
 KugTYSEfBy5XAS6xLvqASrD0z/Pls97+qddEe89PtI/DvKRLKhj1XGsaNwllEtZe
 Ej9MR77+vJbRSB8dnZzFSMy8GirOc5jkwcR/vyJw5oba7SfGtMtotwq87Zh9mEmO
 KLbN1kUC/rRdz06Pr7aYnAI12M14WKpsQGZgr0kf/KIZluRdtiTaXfUYv9nsouft
 yCCsZL+S1tvlVo9/W3zxeXEZBbeI0QOnU5vszw4xNsu1q/nEag6R1ORTjmFJIlpP
 DecliYSgJ5kSnc3iCPbh4Rwx0iqPkiA9yQaJsRzft0qaPUYbYDGQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4awywqg21p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Dec 2025 14:22:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5B8EA293021086; Mon, 8 Dec 2025 14:22:42 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012071.outbound.protection.outlook.com
 [40.93.195.71])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4avax7tjqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Dec 2025 14:22:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sc1eWYcGrCrdRWWTWdEzJGxc0rNysnArCG08bM6K/VyZ7IWSZ5vg37CTyFUmXYIsCvvp+cGJWtDrYjf+cWmIGlVxlTEB+gB5YOZtL744Bc/THjOSvYyP52UG3u4U44GFCJrI//2QSJi8BGAABuZbMM0XKQoX5fhgIymnhmIbUWFplnCtqrzJwDM7AeghVNG7yEidxZC3RS8Uualr6SCILdSbsvK0nLXWDeY0qg/YHI4s5yTNSyToMDL518ao5ycWZzF597JvLBXElcloxGydT9dtFgjrlj+uI12LXYKA2QFeOFIHV4MntcivO+6OCtdQCPWb843V3H2gKHb1laa9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=au0b394Nq4FQbhsMxwMN958wnk9NmKd1zi6cqoRGquU=;
 b=QNx1niC4uS7+BGqXBl4gSXPqlWYdLIi7qPP8gqcn5lPMgJI0LTq2IvW/C64VBXrsLOV193ttDKEiuBdMBNCOzzHg0/m5DmQPOK4B2/kMXm8TtTbAVfoGO0/pWyPxEiyWYjpz1xwh493WwUAC2pKDk225CiRLKAD8uHHaiKqey6KIrNy3atZzPOP2tUdnmjrmrxWINyKzU4eiQiD81foQTvx9CQVrvMsxwhy6TJGXOhrDEVKBg81H+sD2TfCFOhyVn+LZc0TNfcVcpWcyjpZ1iuluOznOhucCSrYPZbCaDw5fVtj98/Br5h2NccVsaLraQ9+6uhxx+oqlsSVb4xwclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au0b394Nq4FQbhsMxwMN958wnk9NmKd1zi6cqoRGquU=;
 b=sMcuGkSSXajICz229y2n0mOh65lQJevP6/oKr4ZrNnkxZ1WhrnwjX86g+og1+SipMm2p3+NpONoChR7zhqmLsvA9ywFj354+kKa0rbNaNtVCWnqVskKByRpvgXVSrfZz0UERkEV64CUtmSSwqL89v9nuU10RVlDtMm+x89bSt3g=
Received: from BLAPR10MB5170.namprd10.prod.outlook.com (2603:10b6:208:321::18)
 by SA1PR10MB7553.namprd10.prod.outlook.com (2603:10b6:806:376::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 14:22:37 +0000
Received: from BLAPR10MB5170.namprd10.prod.outlook.com
 ([fe80::f215:a25c:4fce:d191]) by BLAPR10MB5170.namprd10.prod.outlook.com
 ([fe80::f215:a25c:4fce:d191%6]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 14:22:37 +0000
Content-Type: multipart/alternative;
 boundary="------------PDbFwrZ5Y0B8y0H8eqPoYQn7"
Message-ID: <bc892dd6-d54e-4e0f-aab4-5295cdf93291@oracle.com>
Date: Mon, 8 Dec 2025 08:22:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Live update: tap and vhost
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Ben Chaney <bchaney@akamai.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Hamza Khan <hamza.khan@nutanix.com>, Joshua Hunt <johunt@akamai.com>,
 Max Tottenham <mtottenh@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
 <1728acb2-e098-490d-b37d-7455679ee3ba@redhat.com>
Content-Language: en-US
From: Mark Kanda <mark.kanda@oracle.com>
In-Reply-To: <1728acb2-e098-490d-b37d-7455679ee3ba@redhat.com>
X-ClientProxiedBy: PH2PEPF00003859.namprd17.prod.outlook.com
 (2603:10b6:518:1::7b) To BLAPR10MB5170.namprd10.prod.outlook.com
 (2603:10b6:208:321::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5170:EE_|SA1PR10MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 7176d91c-ccba-4c45-5712-08de36653c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3pkaHdVb1hLRDJYSTU0eVcrb1c5WGZSYWNxQ0FqTHkzZmRCakJsMDEvNkJ3?=
 =?utf-8?B?S1hjMk03RVZMVjBMd3pPdUxHM003MU1DdlVraTBiNEVqZkhqcml6TC9GejNs?=
 =?utf-8?B?VFBpOXIvcy9XbEVFU3JOU2hPMEphbHNweVpQTkprN3dFdnBSTHVweTR1dHc5?=
 =?utf-8?B?M0pFS2lHQ09FQ2laODM1cHVId2RFcTA3WlM3a0ZPUStqMTZqY21LdHpZNHRx?=
 =?utf-8?B?UWJzVVY2amxrSHAwYnJIMkF0ZmJ1RzRlenM2K0orMW9rRDgvZS9xeEFvalFR?=
 =?utf-8?B?K3Y5K3J1ZFZvNWlCN1pKeGZ1QS9CTXNweFJnM3JqWlhWYjNDMkVnWVJTbjcw?=
 =?utf-8?B?K28vTE0vdE5aZlZua2pML3dZcWdvbnFXZTREVEJ6b0FpOFVDVGN1ME9pYXNq?=
 =?utf-8?B?Y1Nzb1d2Tmx5Q1hreXpTRURpQUxSNkhXdjJ2R2RST3Jna2I4NnJQQ2wrbXRQ?=
 =?utf-8?B?cmNHYU9FcExIRkVpZUpZeDFMQWZWcXNUekVSM3lneFgvQVZnUUVmLzZuY0ZB?=
 =?utf-8?B?U0hrTklBTGd1aitHVGF2V0J1YVEwTm5yUkdzVzFGdlNOSUtkN1lLSnRFVHRX?=
 =?utf-8?B?Zko2ckJQMGFPTFlIdld6UEhlV3pXZjBqMDdJUlNnemRHTlo4QTlPRVoxTkdQ?=
 =?utf-8?B?MXFCU0VZR3duOWZSR0x0QisrZ2l6Vkh4RGpRRFA2WEh3czcxK1doOEpMNjh0?=
 =?utf-8?B?aklKNFpObVpqTkdiZFFUOVZRdEcweVlkOTVYNjFjQi8ycXFhOTcwcXh6ZHpz?=
 =?utf-8?B?enJrS0dkRXptblF3clFJM1c5UUJSZVh0QU9zT28rOEh5azVxdjY0QVVmbG5u?=
 =?utf-8?B?T3ZKdEJESCtjQUNTbGxtSDhTTkIyclBBUml1K2JJTFA3QjZYNUZiUDBHUU1Y?=
 =?utf-8?B?aVYwVWpRL0NmZkNsMzNqa1A1SVFjTDVJWm1yWXFXN2VMOGpRSVBWdWN0NDhF?=
 =?utf-8?B?NzB4K3pXeWZ6dWcxeHRVczZSMS85cGNHdzVuaDlRODBPdGNaTjJORXJLQmVF?=
 =?utf-8?B?eWxOUGE2Vm5obVp6T0hTcW9WS0RiZkg3Y0w2c0Y0Q0h4WFEyRU5UQzJZd0JE?=
 =?utf-8?B?NGR0b0kyMkFXMWwxYUdObXVxb2hpaW5QY1BBZG1XTFpXTmdueHFGWEdZeG1j?=
 =?utf-8?B?UExPWSt3MVQzN29IWDdWOThENDFwL1FVbkVkZXlBSWUrSXZnWVNON3VpK0p2?=
 =?utf-8?B?STJhL3k4Ym1EWEozdDVMS0J6MXZWL0t2RFFsNUhPazk5YmVzQ1N1WWRqUjNU?=
 =?utf-8?B?OHFwVkJUQ3hlamZMU2JWQkwrL3RHRC9EZHVJM2ZSWUhrL2lLbFhSSUhZak94?=
 =?utf-8?B?SnBMSGY0WjE5ekE2QzRzS0FBQVNaVmdrcm1HZURBRStnNFVsaVlJaUQwa2xJ?=
 =?utf-8?B?cFl6L1VBbjhTVzZ3SlJlZmh4Tk8wT2FMZndSbW1tZlkrZjdka2JLemErcGRj?=
 =?utf-8?B?dXlBckx6TjMzY1M4L0c3YmJ4K1hjdHdvbG1selIyV2hzRVBHS0xaVWNnQlhW?=
 =?utf-8?B?Rm13OFdaK2hRNUhoM1BiMlVPcGJieE82OUpIU1AyZU95YlM1bEhmNEVqNk1N?=
 =?utf-8?B?eEV5MHlwWExZOEtFMklKYmF3dERDQjljdXJXN0lCdllDcXZJY082MjhlME5U?=
 =?utf-8?B?Z1hRN2hZakZ3Z3VtdHZ0QzVRR2xKclMxUWMvTHQvK0pFODJGUnZXcnJ0NUZp?=
 =?utf-8?B?OFpFRm1oWHZwSVNtV1k2SUEwSUE5MCs5ZlpXTC85ak1XLzVLVTViWDBVMjI0?=
 =?utf-8?B?ZGFLV0RiRVZRNElFenpVckFKczVkYXNHV2RMaDBLUldtc1R6QTdXSkpWbjMr?=
 =?utf-8?B?dzA2SGEwNGZ0Y003d1J3bUhuemdtSmpjQnp5QjNROTVrRUdiMmhCMXlEc0Ra?=
 =?utf-8?B?ZnhQcXoxMDBja2dqWWt6cnlkenU5UDY4eFQxaTBFdGVuVjhuVHd2MDdKMW45?=
 =?utf-8?B?NUNXUVRvbDVzQzdQV0VNcTYyb0JhS204M2ZtaHRDVTNVQU80TktYK0hQblpn?=
 =?utf-8?B?dlpTcFZ0d3NnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5170.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk9HWVRKcUtHZ1pIeXNMSTFESktIOG0wdzRSZjhOeC8rS1grYndRN212d1Z3?=
 =?utf-8?B?TFFjdmdLUU1CcTIxcWcyM3hoZjJVNTNad0lMYnhVOUhIdkxGWjdVVmd3SXht?=
 =?utf-8?B?RmNNUVUyUE1BbEkxM2pHWVBLWmpRVVNPQm9jLzdJcklCQ0VBTElBZ0NONnM2?=
 =?utf-8?B?R2pyb3VYQWt4YVBLTnRYeVdUdy9NNGtQUkFRemZ5Ui9oeHZBUnpkMFBzckhR?=
 =?utf-8?B?bWlLTmdJZ1YrczZOREZKMmxLTTAvdUtDMVNVeWpRcjh5VlVpdWJQM2l3dWs1?=
 =?utf-8?B?SnlCTW4rVUhpaVBqbFg5QmtLYWN1U0FqL1U2bVIxYnE3QXJ0TndZOFNZc251?=
 =?utf-8?B?R3EwVmZqazNLb1E0SlJnNHgzM2hhRDFIVkdjbGlXZ2ZZVUVoeUdKWWhWQ0Nt?=
 =?utf-8?B?QTJDdFBOQU1uZ2cxdXZmbnRUWEFUZGtmNlpsZlNLMitianF5Y21CenhGQ3dJ?=
 =?utf-8?B?Tm4xYUdEY082NnBNVHB4eldCQU9xN2IxM0VEc1lFYTJ2YktHWXlXaFcrVzV0?=
 =?utf-8?B?THVSOW5Ccm9xMDRrSVVSQWFxRGNpSVdKZFBZL1Z0VkhVdlRSdEV2RW01MTQv?=
 =?utf-8?B?bElKKzRpTDRlaVAvTUZya2hsYnNFZFZ1Tk1teGIwK21WclE5ZnBram1KSWxY?=
 =?utf-8?B?ckQ1dHAwOEp1K3pVei90akttUVNtZ1JDM1lWZDZvT0NEVnlNcHU3Zy9wYmRa?=
 =?utf-8?B?aFQ1TUpqSDBmVHVRcjAwRFp6cU0xOVc0cjdBZTNTZVRvcWpjRklHeTM5QVdE?=
 =?utf-8?B?VkpVY0Z5V08yK0h0NUl6UVh1c2Jtd2o5cldPbTJ1SzNvZ2s0OWF6M1VWbE5X?=
 =?utf-8?B?bDlRc0Z0WDVsTUcvYnUrb29aaXpyM2k4aVhPbDJFWDFQYU01VnBPa2g0cEtl?=
 =?utf-8?B?bVh3WkI5WFRCNmxna1FjNi9mVlJlR1ZWT3hVZGhjTm5ZcnFSRlVidEpVVXM2?=
 =?utf-8?B?Ym1MeXlCdlJMdDA4S0tTSC94SGpHMXl2ZnpiejJENDNPbGsvR1gzcVordUU1?=
 =?utf-8?B?QmRiV1l2ckIxM3hjZnM4WDJDMWwwNUxMNFhFbzJhaGVYNUFGYS9WSnEzL29z?=
 =?utf-8?B?Q3piR0NWS3g3NmdReS9XQXhLdFc2SkNzTFhyTUtHVHJ5a2hMWXZ5ZG1ITTRF?=
 =?utf-8?B?ay8vNmMvbUdNQ3RtSFBVWkZnWmRRQzB0K095bk50aVVZeWxRZStaaExBdTlT?=
 =?utf-8?B?ZkF1Sk5IU2QrWGxGUkpZRUU3bzQ3UlpVQlAyUjl6b0V5ZW53R3J0QW9NY3Q3?=
 =?utf-8?B?a3lJb1pEcE5ScFBGRmRJUkVZVDU0QzVkYkhJOGNCeC90UmZLcENLZnF4eU8x?=
 =?utf-8?B?a3NDajFEOURtTG5CWW03TDNoTU14RElGZXV0aUNyaURDamkzdFhzTVhYR1I2?=
 =?utf-8?B?R0k1Y2NJMjVscVg4T1IrWlc0aDIyVlc0YkpSSW9ZeVFHblRpa3NEQlZrMlRT?=
 =?utf-8?B?MFF6WHlWaVM2VExLYXRhVkg2dWlxSGJGL1RPZXY3N2dmTG5qcmswKzBSUGsz?=
 =?utf-8?B?MVVSMW1PcWlETDFPMTNUQTlaRzBDMmRvcmpSajY1VFRhVFk5WVU1L3lRZUtC?=
 =?utf-8?B?eVZCL2VvTEV6akZLNkdza3phYXFDRDkyZmwxdm5sWHpKcFNvTlg3YVZ4TEJF?=
 =?utf-8?B?RSsyZXE4RWh6TnJ4Z2N4bHFSdGppYm5teUdMQjAzU3k1SVpSQVdreVl0US90?=
 =?utf-8?B?ZTgwT2EzSkZVVnNhdUMwWGlKTjM4NU4yZUJ4cWsrY2tQNXFnN01HOXpwWmRH?=
 =?utf-8?B?MGU0YTN6L1hWb0x0UU5rVjUxd0xNcWhGWnJIYWJyVnNhOGxLTWtZTk9JM0dZ?=
 =?utf-8?B?OExqWlpOZ0d2TDFiWk9wMHZ1aTVvUW50QWU5WWVVK1ZWV05TUzFhNTFnekhW?=
 =?utf-8?B?MjJWa1Z0TWFQaXRQYnJLbTNFT3NMSEI5enBLOVZrQkcwVzFzQjlTejRmY1Jm?=
 =?utf-8?B?SHNxSUpjWjJEMU84akJxV0krSFBNNktZck1uNzNiczZCRHFQZkVDOEtpekdH?=
 =?utf-8?B?c1pta1plU0FKQXR4UW9ySWlPcG5DY3lVRGRkRmdkK1djQ2xMK2hzUHpYZWsv?=
 =?utf-8?B?YXIzL1hPWWFuQUt1UFNsWTFrYld2S0xpM0ZRTFBRZTNtdVhHdkZpR0Ftem5D?=
 =?utf-8?Q?UA1Na8RaxyeO1v+4KrRFYgmjs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WRMw0gSvfJFn3kjQosSNr1BSKyAGhpp82aR6WBgEfiPhQq3uQF+ECKooKMe1k96LXHwqoyjDFsLyBuvnuQp8T+3tNDDD85P0v0IFB9JReLjcvUasgTVSHtVdiQ2cEPQp34u5wsCTsVIPK/m+t+D0G/lk7+gW3O+HnvsjrFGK/DRmBuMxv1KlDEzmiHsgiAKvvIWE1YG2fHacE8Jj0LdReNZU8tvrZHWQuxulm67eDsRfoS8FkrvIe76zriEmzpsBHn1sPvkujJK+3AGp24NNLfhrkwt0/8BaIPeyAklEZkgv51GIEztj8kz4SKF0itP77IrDv0qsLMx8kXylX+6fqJaanatdT48gHDdlDdlvJLV4P83MfpyuBnChmuPGegewnboPRgddJqUorfnUDdu6/g/kMb2s+0rRhQ50MioQItJzr8TaL0LmoXi6bke+udOh1nRYwPTao98tnkm3yv9hr9mfeferEY/w3J/NS/he4thJWgfcHK5tKbEXo1VMJcXS8etLZxrm/1XmshVy+6+nKgsaTOn6hNaV23TmHyXwtZu5XjN0GhCFU5xpQxI0Ug4ZA7/nVo8YMMDbzYqFfGoLM7rCMiAqDKpq5owi8guowFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7176d91c-ccba-4c45-5712-08de36653c7a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5170.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 14:22:36.9852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zHs8iMKod5hZTlYXZqvT/ciwN7zBztnZamW0+SuCx5EsAtohzGxDPcQug/HMMWBlOwVOc+Jzei/HhVyqTvxLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512080121
X-Proofpoint-GUID: 9VaweeMoRtyzLK4iSSsbNwKXToFkW4Q6
X-Proofpoint-ORIG-GUID: 9VaweeMoRtyzLK4iSSsbNwKXToFkW4Q6
X-Authority-Analysis: v=2.4 cv=T42BjvKQ c=1 sm=1 tr=0 ts=6936df33 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=X7Ea-ya5AAAA:8
 a=yLDGqYXBrX3OeO2EFFUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=20KFwNOVAAAA:8
 a=_qMhhYQDH5SjHrDbQFMA:9 a=OVFiIicTitxMOHad:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDEyMiBTYWx0ZWRfX6XQxarhzzslw
 OaXaKlCrypNMwexViho6EI7r2+LbVYzIZUztoqF51XrDAvfm0h8Ekv4/PoqNDHyqjpgm+/gqj6n
 OwPNn5XmjmA3zd0kyHZtlS6E6fSwW3Ri2ktbH8AC+4qnV0mlzMEmuqXdovpQ6wS7tDZBEEllPiw
 Qn37qUfEatWjvbxQoDxbdLdMm2r11de7RNKkPiEZIPm7acqk9gDYu3rcae0uATZG2zE+NsCqWTs
 cqnzmXqbXVI7ycNAZvUdN2MdmXlyuqhNj3Aq4kPnxDa2shMz7NJyZ0P0eogu2f6E6W6zKhrtJWN
 Qy1BGZx7wxof5vpt1Zscr+2fnKdTn87hCHtJ2YS2yCRFZ+RstrI+eD0Nj2NJylEm0X9QstgcuMm
 86+42Elu37eQAUUta3oYoqCDH3kc6w==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--------------PDbFwrZ5Y0B8y0H8eqPoYQn7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/8/25 4:08 AM, Cédric Le Goater wrote:
> Hello,
>
> Ben, Mark,
>
> Since Steve retired, we have generic names under the "CheckPoint and
> Restart (CPR)" entry in MAINTAINERS. Would you be willing to step forward
> as Reviewers/Maintainers ?
>
You can add me as a Reviewer.

Thanks/regards,
-Mark

> Also, do you have a gitlab account so we can copy you on any reported
> issues [1] ?
>
> Thanks,
>
> C.
>
> [1] https://gitlab.com/qemu-project/qemu/-/issues/3235
>
>
>
> On 12/3/25 19:51, Ben Chaney wrote:
>> Changes since v2
>> - I have taken over this patch set since Steve retired
>> - Added comments to explain the order of events
>> - Remove redundant reversion to cleanup git history
>> - Inclusion of virtio and stub fixes
>>
>> Tap and vhost devices can be preserved during cpr-transfer using
>> traditional live migration methods, wherein the management layer
>> creates new interfaces for the target and fiddles with 'ip link'
>> to deactivate the old interface and activate the new.
>>
>> However, CPR can simply send the file descriptors to new QEMU,
>> with no special management actions required.  The user enables
>> this behavior by specifing '-netdev tap,cpr=on'.  The default
>> is cpr=off.
>>
>> Signed-off-by: Ben Chaney <bchaney@akamai.com>
>> ---
>> Steve Sistare (8):
>>        migration: stop vm earlier for cpr
>>        migration: cpr setup notifier
>>        vhost: reset vhost devices for cpr
>>        cpr: delete all fds
>>        tap: common return label
>>        tap: cpr support
>>        tap: postload fix for cpr
>>        tap: cpr fixes
>>
>>   hw/net/virtio-net.c               |  26 +++++++
>>   hw/vfio/device.c                  |   2 +-
>>   hw/virtio/vhost-backend.c         |   6 ++
>>   hw/virtio/vhost.c                 |  32 +++++++++
>>   include/hw/virtio/vhost-backend.h |   1 +
>>   include/hw/virtio/vhost.h         |   1 +
>>   include/migration/cpr.h           |   3 +-
>>   include/net/tap.h                 |   1 +
>>   io/channel-socket.c               |   4 +-
>>   migration/cpr.c                   |  24 +++++--
>>   migration/migration.c             |  69 ++++++++++++++----
>>   net/tap-win32.c                   |   5 ++
>>   net/tap.c                         | 147 
>> +++++++++++++++++++++++++++++---------
>>   qapi/net.json                     |   5 +-
>>   stubs/cpr.c                       |   8 +++
>>   stubs/meson.build                 |   1 +
>>   16 files changed, 279 insertions(+), 56 deletions(-)
>> ---
>> base-commit: 9febfa94b69b7146582c48a868bd2330ac45037f
>> change-id: 20251203-cpr-tap-04fd811ace03
>>
>> Best regards,
>
>
>

--------------PDbFwrZ5Y0B8y0H8eqPoYQn7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#f9fcff">
    <div class="moz-cite-prefix">On 12/8/25 4:08 AM, Cédric Le Goater
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1728acb2-e098-490d-b37d-7455679ee3ba@redhat.com">Hello,
      <br>
      <br>
      Ben, Mark,
      <br>
      <br>
      Since Steve retired, we have generic names under the &quot;CheckPoint
      and
      <br>
      Restart (CPR)&quot; entry in MAINTAINERS. Would you be willing to step
      forward
      <br>
      as Reviewers/Maintainers ?&nbsp;<br>
      <br>
    </blockquote>
    You can add me as a Reviewer.<br>
    <br>
    Thanks/regards,<br>
    -Mark<br>
    <br>
    <blockquote type="cite" cite="mid:1728acb2-e098-490d-b37d-7455679ee3ba@redhat.com">Also,
      do you have a gitlab account so we can copy you on any reported
      <br>
      issues [1] ?
      <br>
      <br>
      Thanks,
      <br>
      <br>
      C.
      <br>
      <br>
      [1] <a class="moz-txt-link-freetext" href="https://gitlab.com/qemu-project/qemu/-/issues/3235">https://gitlab.com/qemu-project/qemu/-/issues/3235</a>
      <br>
      <br>
      <br>
      <br>
      On 12/3/25 19:51, Ben Chaney wrote:
      <br>
      <blockquote type="cite">Changes since v2
        <br>
        - I have taken over this patch set since Steve retired
        <br>
        - Added comments to explain the order of events
        <br>
        - Remove redundant reversion to cleanup git history
        <br>
        - Inclusion of virtio and stub fixes
        <br>
        <br>
        Tap and vhost devices can be preserved during cpr-transfer using
        <br>
        traditional live migration methods, wherein the management layer
        <br>
        creates new interfaces for the target and fiddles with 'ip link'
        <br>
        to deactivate the old interface and activate the new.
        <br>
        <br>
        However, CPR can simply send the file descriptors to new QEMU,
        <br>
        with no special management actions required.&nbsp; The user enables
        <br>
        this behavior by specifing '-netdev tap,cpr=on'.&nbsp; The default
        <br>
        is cpr=off.
        <br>
        <br>
        Signed-off-by: Ben Chaney <a class="moz-txt-link-rfc2396E" href="mailto:bchaney@akamai.com">&lt;bchaney@akamai.com&gt;</a>
        <br>
        ---
        <br>
        Steve Sistare (8):
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migration: stop vm earlier for cpr
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migration: cpr setup notifier
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vhost: reset vhost devices for cpr
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpr: delete all fds
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tap: common return label
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tap: cpr support
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tap: postload fix for cpr
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tap: cpr fixes
        <br>
        <br>
        &nbsp; hw/net/virtio-net.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 26 +++++++
        <br>
        &nbsp; hw/vfio/device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-
        <br>
        &nbsp; hw/virtio/vhost-backend.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 ++
        <br>
        &nbsp; hw/virtio/vhost.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 32 +++++++++
        <br>
        &nbsp; include/hw/virtio/vhost-backend.h |&nbsp;&nbsp; 1 +
        <br>
        &nbsp; include/hw/virtio/vhost.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +
        <br>
        &nbsp; include/migration/cpr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-
        <br>
        &nbsp; include/net/tap.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +
        <br>
        &nbsp; io/channel-socket.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-
        <br>
        &nbsp; migration/cpr.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 24 +++++--
        <br>
        &nbsp; migration/migration.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 69 ++++++++++++++----
        <br>
        &nbsp; net/tap-win32.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5 ++
        <br>
        &nbsp; net/tap.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 147
        +++++++++++++++++++++++++++++---------
        <br>
        &nbsp; qapi/net.json&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5 +-
        <br>
        &nbsp; stubs/cpr.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 8 +++
        <br>
        &nbsp; stubs/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +
        <br>
        &nbsp; 16 files changed, 279 insertions(+), 56 deletions(-)
        <br>
        ---
        <br>
        base-commit: 9febfa94b69b7146582c48a868bd2330ac45037f
        <br>
        change-id: 20251203-cpr-tap-04fd811ace03
        <br>
        <br>
        Best regards,
        <br>
      </blockquote>
      <br>
      <br>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------PDbFwrZ5Y0B8y0H8eqPoYQn7--

