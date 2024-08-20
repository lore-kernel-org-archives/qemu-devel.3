Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F61AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 16:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgRjB-0006ul-I1; Tue, 20 Aug 2024 12:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sgRjA-0006uH-I6
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 12:29:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sgRj8-0002SP-Ep
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 12:29:00 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KF4MhD028061;
 Tue, 20 Aug 2024 16:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=LtC0iQZ0Fu19RZDz36UZsOSbnbI25pzT4lTClA87y84=; b=
 MF+X7vbhUKwn2yIomftoh1121fHhbgxu0Q7FXDntcxuj+rA4ntbcdY83eqmilucu
 91Bla0O2G5rWgsGqWwV/sEckM77rzqe+Jn6we1K09/5s2D3PFTI0SIM/pQ3+3/Ko
 KUsTYudx/5NlDbJsSUrGih6tmb6Lv5yTKjhJxPi988UjGY1ZtLQ2Bm6EIrt1+xrh
 MBGgYrbXc1qFy502h/akFAc7XWHo52Lr3m94HO+Ee0lEAuynUqVykROtfecWWbVf
 6NsxfJQq9DnXwO3mf6z9wfNcJGTinHq2FuqyKthcNT/Fr0BW8Kue8wid3ww/PEX6
 xbT8UE1P3HjCTvAp97wbuw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3dnpbc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Aug 2024 16:28:53 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47KGJOXP025990; Tue, 20 Aug 2024 16:28:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 414xjg0d7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Aug 2024 16:28:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxVls+BMImyT0qx+2bnGobbmRBX9iqhCnNXoUD1x4cK2vFFwxVe7dlRCHbUe8VRrXEkOb9W4P4McPa193Pg+RaodjgQzpvPVtCp6RCEMJVQmFExXde85/Z7YouvKiP9TZO8HAVEjuZfudngn/faLUzk3+3r0IsjsPhZYIWUdFgGETSYZPyGRiMs//YqB/froP4Up+L/PMcR4uEHr2gXrhrFtJwkuAQXIjY6H0mIWH6JU8PRhIBHdiP0uioLG72+utNnRUILUo43WvjmYpAtkqj5YOxo1SFTUW5BrQGYZWGgD1mLaLnOQEHhy3RN5bt7WM9L4dBjMJWpFP+WWxriI3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtC0iQZ0Fu19RZDz36UZsOSbnbI25pzT4lTClA87y84=;
 b=cJnKrvRQoCxI0UmY4WGdIZ3HZvlAErFM7nRXTsMPCeKYGMiFUVK9N+X07zZAKzG9wbUtbJVTVOoceVUjYH2/nC5EjCp5Bcu7Ic51NRA8cIAWCFZkOAW0TWT8nBowPVeF+Bn3Rt/hj21IEvmylqRCD+TT3yHrHREYgZ1Q7rYmSaUQjew/onxNlHD6iKftoURaoK+Zt+WPYJho/oqjFNQo7PQqQ21Mha7tCtKQJWHNXKEApwuQBu/eOy5VjdhfGTqnnJLVvk2QME5NkuJFV1qgHSEj4Ni89y6+lILbNyBMpRKuP6jMIxRfqGW+YNTlNWfJxQUssZoAvKFbwiEYJP47iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtC0iQZ0Fu19RZDz36UZsOSbnbI25pzT4lTClA87y84=;
 b=ZsMWscZ6V9ENehF18CdNx8iONCkEtp3s8jXnF9r7o4WGONOf8FtKYP4m191LitMOkbZ5aOdkmNlSA0gmb1lzXbzWnoLeq8wUnn8potOIwyxPWE9Joho6/FPVaK7j2vNV4wpB+LZjp5894TWPKMnOVfhYcqmFirOBJXbK6cDjGwo=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by SJ0PR10MB4733.namprd10.prod.outlook.com (2603:10b6:a03:2ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 16:28:47 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%5]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 16:28:46 +0000
Message-ID: <28d2f43d-4354-4e12-87ba-93e33806b5ab@oracle.com>
Date: Tue, 20 Aug 2024 12:28:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec (reconnections)
To: Peter Xu <peterx@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n> <4f6200fa-c052-4295-b71a-c6deca11db9f@oracle.com>
 <Zq-oDMMYTktnQUIA@x1n> <ecbee102-262c-47e8-9da6-14e44f85f032@oracle.com>
 <Zru-IMUqg-6-1sbo@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zru-IMUqg-6-1sbo@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0509.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|SJ0PR10MB4733:EE_
X-MS-Office365-Filtering-Correlation-Id: f70a627a-d5d1-4691-2cb6-08dcc135294a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnphNWJaSk5DSjBJWVRSZTJobHExczlrUVR4SWYzeDlRblJqZnZJYWtLQU11?=
 =?utf-8?B?QmNxc25LaitYNGVuSFJHQVUvOEYzRWh3bkdZL1AvK0Y4OG1RQ3N6ckhmSnRr?=
 =?utf-8?B?ZEppY1k2amN6TjNWQ0NOekxvNUhsRHRoMWcvbDRqWllady9OQ3RaVHJHNFpy?=
 =?utf-8?B?MVdpUnlCZENyQUllS2IvbHphRGRnaEZLZDVDcmQxeVF5eXoyTkpZVHBsYTZ4?=
 =?utf-8?B?RmNYWDVwZU14bTlON2ZQd1FxY2FXRTlHbzhYWlN3TkFLd0VYUllGYjNjaC9t?=
 =?utf-8?B?NUFOaHg0TWlMc1VwOHZQRWp0RTJtV2dURlhCMVlYSzNwUzUzMk5pSlpjWU1o?=
 =?utf-8?B?ekFUbVVPbkRhQU5aaXhtaE5Ra29jemR3aG1iT2h4Y1Zyd3lMcUsvUUkwcm5L?=
 =?utf-8?B?ZDZiN2JmYUtIWVpqcVVXQURRZGZybXZ6bGJGZ2VsejZPUXpqdzJFV0dPSTJl?=
 =?utf-8?B?anh5MFA3WERCYzlJV055bG9DRmE3MFpFYi9XTi9FazVZVitERW9iMzROb1hh?=
 =?utf-8?B?UGhnYWV3c0ZVWkd3RTNRVU9TZUdaMm4vVlViQ1Rpd3Jxb1dwSDVBTzJJbTJx?=
 =?utf-8?B?K3NMdDVHR2doNDdEcGc2WGJUSWwxZVh2dFJpeXh1Ry92MEszNWpWcXpQUERv?=
 =?utf-8?B?Ymg1L3BYUHVoNXBnU0Rudy9uMGkzMGYvYTcyVEtMeGVvaDZVWU85MnJEVDgz?=
 =?utf-8?B?c3F1TlNoZUx3d1dSSzdsQVl3MDVuVnFIRHg2UzBwUkxsNUhhV1diRkZ0Qzlh?=
 =?utf-8?B?Y3hMVGhpVGhsSTVqb2d1bWgvV3hOTENWd2hkcndvQXE1YURkT2xZcFNyL2xG?=
 =?utf-8?B?aE5UdGZTa2pCQnV6U2FCMTVMU1M3bVd3NGEwUTFFS245N2RHR1hjazNIRTIz?=
 =?utf-8?B?RWt6c0NJUS9SblRnSmM0aFJUVVpYdnVoOGtOQ1RuVGRVK0JYMUY3aklVU25w?=
 =?utf-8?B?QWlIVFNNU2hjVHpuUDNybnlmTVdHVEVMb0NBVWd4VitHVWU0R2NqY0pUOW5B?=
 =?utf-8?B?UHBZZTVmallXWmJYL1BTbVNlRUhVRUs4VnZ4NEZZc0txNVVrV0tOdWRBTGo3?=
 =?utf-8?B?S2lnZUxTbU9TdU16MWdJMTZPUFN5ckwzaG5OaEFuTmdqZTZQYTZFdFdSeXlE?=
 =?utf-8?B?MzF1bW9tQWZUVTJMSkZqcWIwWXVNWFRqMVVpOHMrb2d3RHRFYmQ4eUg4WS85?=
 =?utf-8?B?c1ZLSThkOG1nR092UkNOVWE1dXFIRU5MZXNnbHhpYWpmaVdkdGRhZXBLN0Jn?=
 =?utf-8?B?UGo5WXQwVFBwbndLNzN1V2lFQTlDNjVheWNMbEJRVEZlaXQreUJXSDZ1eUg0?=
 =?utf-8?B?RnZ1M0p0SHZDU2R4MTR5UHJGNndFV0RvcHpFZTcvMDltQWRSekl1TXJEVVlG?=
 =?utf-8?B?MzU5bFhxZHdhNlNZbGVmOE43MmNmdG9iS1JzTWdZZnZtM3prejRTQkJCQzlP?=
 =?utf-8?B?ejR0dXFwRTJERUhOODBMNTlWOGxjMENoTy9lUkFQaElMNXErTlNkazY2Y0VK?=
 =?utf-8?B?VWhKdm9lUXE2N0xXQnhLWlQrZGhYUVgxZ0locDZlaGNyQUlsODRXRGE4L20w?=
 =?utf-8?B?WlhjK29zelVJdVVSVkZDZTJlOXkweGE5WjEzRmtrVE55V0JpajlEKzhmQUQx?=
 =?utf-8?B?UlYrcDBWbnZ0MllUZzBSRVJoUFQvMER3cVRiZ2ErblZpM0FMdmFhdGxmWVJY?=
 =?utf-8?B?SW11OWtiVGlaVjRCQXpCZVVORlB5NnpxckxGeWVCRUlnWEtYcHc5N3Z0aHpD?=
 =?utf-8?B?eVk0ZkZOaDByci93NVRhWEpqdDJObUVnak1mN0FRN3A0VlNHeXhwTTRvOXFV?=
 =?utf-8?B?WGxKVzdNbVZ1L1dNbmRWQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW5BSlBNdkdJOHA5N1ZwVjQxM3VOUlY3Y1hBOHpSMVVDWm1halBGMFh5SEVS?=
 =?utf-8?B?SHFTb2Jhd25rMzRBZ1NWbC9xK1E1dmdJVUxWSHQvYjIydHZFQjFMOGRwOURZ?=
 =?utf-8?B?WWgzK2pISFBqSlZBSDJhUlZyaVNHYTdIM2JCdGlyeEg0c2ZuODNWbFYyalFI?=
 =?utf-8?B?RERHRGduOERtQWVZVy9aLy85SDB5L3lsK3A3Tkwxb29SaDJYTWo0Qi8yMzlU?=
 =?utf-8?B?N1VmY2doZmx2QkVUOHUvS2ora21wWXp5V2VTNldTbFVxL0liRlErdWs1TzNL?=
 =?utf-8?B?dVJvY1B2a3lpZlUzRlI0TS9WVGFNeXQ5ekcwTVAxZUYyMlNnU2hwMXJLejVW?=
 =?utf-8?B?Q2plNkR0ZUZadmVZcUdXb2tGL1ZPV1hzbnRxdTdTUnpWcGpHU1ZCZVBCbmtl?=
 =?utf-8?B?SDN0U3pnS3pmK09SM2I0MStzbjlnNEVkZW8vZzQ2MllwMVFCeUc0WVBFNXJM?=
 =?utf-8?B?N3MySUxldlNSakR2SVFHbXNZZHpKYkNVSmxzOVg4YVBvMmpDNEk0a0pXends?=
 =?utf-8?B?S3Bodkd1eVdYaDBwLzllS1U1NHh1QVNCQTRYV0pRSS9ORi9ZV1h0M2ZXYUho?=
 =?utf-8?B?dkhQMzN5TlVIS3ptLzBBZ1dMZ2FrSVh6cFR0T0phakRNbXFIbnNuUTRWdjR4?=
 =?utf-8?B?R0RqS3lrdStXQ2lsbTc0amVPMU40ZzhuVDNPcExUcko3YlRUNWJrNlkzWkJQ?=
 =?utf-8?B?Q0dFcW8xeVUxMDdUc1ZrVld0RWdORnY2MWcwZytBUkhFMFEyZ1A0K3JMVmQ1?=
 =?utf-8?B?OC9Hek9jSjNiUnZMRE5KTGNaYVdEK1JZYjFMUEl6bzBHU0Jrcyt5WFpSWFAw?=
 =?utf-8?B?OUxtYUUxekdzUFQyNlB5SzhXVUJHMEJkS3dHdGVIZ3JGaU15blRISnk5NXZZ?=
 =?utf-8?B?NytzZlRWVVY1R2dRU0VDcGZ2V1krR2hNc3RWYVRsdllWZWhLWjdKZkhYOXI1?=
 =?utf-8?B?Z2ZkNFAvbnhaK0lIQ2tPVkJvT09aemgrWkFvOW9OcTIwS0tDSWtURjZBaC9x?=
 =?utf-8?B?L2NDYmRzZ1kwVGhMelRsKzh1a1JSTksvWkRTZnJSMTBCTXhOQ1hRTjlwRFp6?=
 =?utf-8?B?WGk0SmxsWXhKMEtja3ZvYnlqSkZWRzJrQlQvNDRzS2hpd1lQalErUmJub1k2?=
 =?utf-8?B?REZkY2FLME9aMFJBSFBRcUxhRUgycFlCM3laM0xaejJ1YTJ3QTdBUzEvbmRQ?=
 =?utf-8?B?OXZsR2VxMnE5N0JURGJOd3ZUaGF5akZNdS90c3k3NnFRVjJpTXQ1akVFcktF?=
 =?utf-8?B?elozK2d0UWRWT2RMa3ZFRG41VFB0MkJpS3pQdi94T2x2NXBQL0tSVXYzWjJD?=
 =?utf-8?B?a1NRekVnZll3TjJsemw1amRoeHJnMFowYUQ3NmtmQU5IcTh4czhWbzBFd2du?=
 =?utf-8?B?NmJtdFFpWVJKby9jbnBpSmFPQjAvY2J3bmROamZrZCtTT0dsLzBCZWhKRitv?=
 =?utf-8?B?VDlmK2tyUyt6aU9rV05jVW04R3JCYzFobThlTS9GSzVRdUtnNjJCSG1oL09B?=
 =?utf-8?B?cVlrbGl1LytUV3dVZFZFWTZSNG9OOC92OWV0MGdVMTBuak1QRXBxNGo1Rkwz?=
 =?utf-8?B?SWkrOGtpczd0RnVaUjY3MGNTZ2ljbmNSLzB6OFRrTk1ZcllPczhSdGR3ZGNV?=
 =?utf-8?B?NXMzdkF4eG8vbmQwd3FUUHlTNXV2UjNWdHhiQ2dteGFUMDU1bXJxN2x2TFNw?=
 =?utf-8?B?V0YwUGQwTk1HdGZBaGE0YUtCaGdSdGlVRG90YzJGQ0xWZGp2K2Y4bUx5Q05R?=
 =?utf-8?B?OE9NYjZWRU5HaEtadmIwNzFLNTMvSk9oNkd5TzE4TFBUVUtPdzMzU2ZoUmJF?=
 =?utf-8?B?WEVaMWxlcUEyZzkvQXh3d2k3Vjk1alVBVUl4b1l2SlNNWHRQeVA3SWRGeTZh?=
 =?utf-8?B?VVpoVlpTb09QaS93cjlzakF5TmRERnJ6S0k4elB3Z3BiU2JWY3ZLVWlHWkR4?=
 =?utf-8?B?UGU2dTZ5ZEovdjNKT0VxYksyQlFTbERzaHB1dzNLSWFDRzFNaWhHcUsrSWhw?=
 =?utf-8?B?M0Q0ZmhhLzVBUDhtL3ZNbGZDb0M2aGtsU1FuM2hOYldJMExkekkxMHNtWkdW?=
 =?utf-8?B?clBUR2xxblhwR25ieDF1N3JxSVhhck5GUldKR0RaTTZ2d0VNRE14bzFSc2Nq?=
 =?utf-8?B?UnRQOThjNWc5VnpOQjk5azdLRDU2NXNrZ0o1S2tBRHNqbytjRDd6Zjg2WlRs?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kkctdMYnXVA2yzBc9thW91UVrf01E0OMERnRT2ly9/KD4LHnQf0HRssfK1FEnAeMjY7AdgcpmJcQ7Bh9gL7F2uxeADnj+ZYn/Gl/CB+thQwSzbBOZSJfbAhdapJlmUn5VOGCQTza72dHAyTAQiKE+6LqURjMoSgpdaLmIWrah3YNnOBAH5BoCQ/6KrqvTq086ym8f8BQVkI8J49cBp/Ufwncve63AlQiIINfr+R7ONRJuJLyoQL5xTJwvkHS1+hSX4MZwO5FzHF30UbPIWjM3sNKT0xIhXgF0RMRSDASffvhcPacz0L2OD2FQFIwsnfu/eHAt3U7h9zUAcGbs0UFYYRFzrMvUDAzMjjufBvPY5odPxvOM9Qp78BICKnvrL66CjpFBPXme8oz4gsQTV6wDnYuszc8fpEQ8Ix740UGVSDgZLdIus9qXqWY988xU+pfzUwhpaIEdRN1qtl1zTAG5JjkLxmWxgKzOfeEcsrLfSnLoeRCD6CR9SpcbhrWd/vFIxcwYH+QHEWGWt7ht0lmE0YXX/w2BeZWiZ1AlrpbSY+f3FQNtvNHkqRQmoMaefhm+yR93LbZzJ0LeyFtxysAf527rmIA75OL52buzcopHGU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70a627a-d5d1-4691-2cb6-08dcc135294a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 16:28:46.2292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89A1A6bVBt+1ERhKBtH+MPSsvjMmwr8BmVyS5xPYucY7n/yKbFaFfQ77G7gQvR/TGWhj82fYc9CeH7TqPoCWWsSkcn3A8pehWlsw3WMpipE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_12,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408200122
X-Proofpoint-ORIG-GUID: KHy0QAj5JFyYL_cxCR2XE5gyUGci7xmX
X-Proofpoint-GUID: KHy0QAj5JFyYL_cxCR2XE5gyUGci7xmX
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/13/2024 4:12 PM, Peter Xu wrote:
> On Wed, Aug 07, 2024 at 03:47:47PM -0400, Steven Sistare wrote:
>> On 8/4/2024 12:10 PM, Peter Xu wrote:
>>> On Sat, Jul 20, 2024 at 05:26:07PM -0400, Steven Sistare wrote:
>>>> On 7/18/2024 11:56 AM, Peter Xu wrote:
[...]
>>>>>> Lastly, there is no loss of connectivity to the guest,
>>>>>> because chardev descriptors remain open and connected.
>>>>>
>>>>> Again, I raised the question on why this would matter, as after all mgmt
>>>>> app will need to coop with reconnections due to the fact they'll need to
>>>>> support a generic live migration, in which case reconnection is a must.
>>>>>
>>>>> So far it doesn't sound like a performance critical path, for example, to
>>>>> do the mgmt reconnects on the ports.  So this might be an optimization that
>>>>> most mgmt apps may not care much?
>>>>
>>>> Perhaps.  I view the chardev preservation as nice to have, but not essential.
>>>> It does not appear in this series, other than in docs.  It's easy to implement
>>>> given the CPR foundation.  I suggest we continue this discussion when I post
>>>> the chardev series, so we can focus on the core functionality.
>>>
>>> It's just that it can affect our decision on choosing the way to go.
>>>
>>> For example, do we have someone from Libvirt or any mgmt layer can help
>>> justify this point?
>>>
>>> As I said, I thought most facilities for reconnection should be ready, but
>>> I could miss important facts in mgmt layers..
>>
>> I will more deeply study reconnects in the mgmt layer, run some experiments to
>> see if it is seamless for the end user, and get back to you, but it will take
>> some time.

See below.

[...]
>>> Could I ask what management code you're working on?  Why that management
>>> code doesn't need to already work out these problems with reconnections
>>> (like pre-CPR ways of live upgrade)?
>>
>> OCI - Oracle Cloud Infrastructure.
>> Mgmt needs to manage reconnections for live migration, and perhaps I could
>> leverage that code for live update, but happily I did not need to.  Regardless,
>> reconnection is the lesser issue.  The bigger issue is resource management and
>> the container environment.  But I cannot justify that statement in detail without
>> actually trying to implement cpr-transfer in OCI.

[...]

>> The use case is the same for both modes, but they are simply different
>> transport methods for moving descriptors from old QEMU to new.  The developer
>> of the mgmt agent should be allowed to choose.
> 
> It's out of my capability to review the mgmt impact on this one.  This is
> all based on the idea that I think most mgmt apps supports reconnections
> pretty well. If that's the case, I'd definitely go for the transfer mode.

Closing the loop here on reconnections --

The managers I studied do not reconnect QEMU chardevs such as the guest console
after live migration.  In all cases, the old console goes dark and the user must
manually reconnect to the console on the target.

OCI does not auto reconnect.  libvirt does not, one must reconnect through libvirtd
on the target. kubevirt does not AFAICT; one must reconnect on the target using
virtctl console.

Thus chardev preservation does offer an improved user experience in this regard.
chardevs can be preserved using either cpr-exec or cpr-transfer.  But, if QEMU
runs in a containerized environment that has agents that proxy connections between
QEMU chardevs and the outside world, then only cpr-exec (which preserves the existing
container) preserves connections end-to-end.  OCI has such agents.  I believe kubevirt
does also.

- Steve

