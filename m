Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EB7C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 16:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWdbV-0004U9-Gd; Tue, 01 Jul 2025 12:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWdbQ-0004TJ-NX
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 12:13:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWdbN-0002wg-7a
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 12:13:00 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9Cxe019354;
 Tue, 1 Jul 2025 16:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=64xxqHN3OqT0sy0sdkfZI6YsTdphCuMtOtfSnA9OJ2s=; b=
 c0cvHuGygkYVNI/ogg+S2O80uUHlwmEKX4p1FdHX99lvQ6r61eisscvResMQD1qg
 fK8JajbE11lLlO3GOq8d5R9f6kLPPSRDEVf+Kc/RvAo4RZ0x9VoqnolozBYXxMQI
 kLLqRJZ+yjNeBsilusI3uj/2n7PZeo2Q6uNmAxomxopQhL2rxJ+V1SjMN8ICJHjS
 Y+XicriZqosKp783n+pZsVqXoni72QaJ8Mv2IH9r8dUyLi5gh6zubRUdXx+kj0f2
 Iw85SurX68pz/7lYtAkdVL2YR6Em4UGZ40eViwm1CHncAml738oiZVgdTRWL9O+J
 m75QNY/CDWDOnofpFZiRhg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef54vm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 16:12:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 561F3Hgg024966; Tue, 1 Jul 2025 16:12:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6uh8asv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 16:12:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAGXlHDZwJ9we69/A9DXfmimrvK7zZjJ4gyy1bzvfz/x5I6qaa76Mk8gYsABIOflBAfzjz8gfOJYk7pKv+nrR4VaKsgVOifOVe/bGukA2XHo2uiXMto9FgLsC6M+UmCikBbWVBSggF5nShS5N6Q4i/XjUx7RMKvk9LcW6xfz/JufTUaScK6jM8mInesFBxt7dVRCD+wHWykpQPrni8vkqCbZxjIeeT3JzhgUMGBOYEKYM8cwSCCS8awUa1cHPpsInG4KsfiFhCiK0iNDwm1FxnhEOsSiKvLaJ4qqh7zLwNfHCg0xQDJvJ9dUZhtkRBDpqYQNTg/FLWnVVMetb5k7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64xxqHN3OqT0sy0sdkfZI6YsTdphCuMtOtfSnA9OJ2s=;
 b=vqkJMOILlKwYet4rq8yYbW6fTAWJeH9+/UTkvggYEY0AzPi80jWTMYiruNHIMUI7cbGtQOa638I3M67G6V6eKVwoxE5JxL7HPizInOlIKTdFye1JxqDS+WZecTwf+UL0Q8bgDDS87Bcl2zV90EVGt5TPqLf6tmrcUlShNdXDwFWoZHs60/xFkyu34AVcRlQN60ZQ2+bev6B3Lw1z5uRS15hdhKLgjTRWVfqshhaYRgrpQrMJLA4EAIzPP1LV1TOiy1q5BvYa02DvI750X1iRyvqKCfzLAW7sy2SWBwWbRbYVPWBA84fbWH2iyTUJ80KD2MewLGd3U/MGRBLF+jsKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64xxqHN3OqT0sy0sdkfZI6YsTdphCuMtOtfSnA9OJ2s=;
 b=YM/f1/jWAy3jdlqNKGR8fwYgt6IoAlFSSHAQUFxMlM51+V9nfZy6PCYdkwb1Mda7d0Jmr9t+IJRY5V5YOy6O/WoF9l8RuR+G7V7A2OdllzxiDKd2rWaSqF9/9DCMkpOGaZQQTFE6tPSPDn/huZZhlTNW5lKF/fEp9mT5Ps1FRRM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BN0PR10MB4903.namprd10.prod.outlook.com (2603:10b6:408:122::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 16:12:47 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 16:12:47 +0000
Message-ID: <ab244c5d-7a15-43ad-a3e3-807f819181bb@oracle.com>
Date: Tue, 1 Jul 2025 12:12:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 18/38] vfio-pci: preserve MSI
To: Cedric Le Goater <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-19-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-19-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0075.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::26) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BN0PR10MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: 001a0c1d-cc18-4458-adc0-08ddb8ba1e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlVWUHFUSGV1UVpBUW5yNG02Wll6dWxnT0s5TWducU05VzJaNTM5SVlWVTBZ?=
 =?utf-8?B?bjkxZG01bkQwWnZYL3M5WmFkbXdWMi9vRFRFWHkrZGMvN3d3d0RFWHBFbGdv?=
 =?utf-8?B?MWRyUFlBQmJ6STYvMnMyUjh5R0VnUTBSWjcxYTFlMVp2WEYvcGNTUEJtbDZN?=
 =?utf-8?B?UVdWd0thZ0JmYVI1QTBDQ1VmZUJ6cjcyN1BPYXd0SkFjVm96R3ZNbWxzU25M?=
 =?utf-8?B?THV2S0twbytFVWFmL0Nlb2JleHlONU5JNWttZmtZeDBjelF2RUljdTR2UVFs?=
 =?utf-8?B?K0hBc1RvenJCVXRjc1krRjJLSHJEcSsyRmFXdEpvRmRCVytHRG1vTktlZmV1?=
 =?utf-8?B?bnNodFpRWlFOL0V1SWprdUsxNUVwbjhiN20xc01leUJ4cmQxbEpCRVJDcURk?=
 =?utf-8?B?WGdtU2pCRENJekxmMmFkYm0yaDd6c2tOM3hTTFRXWDdTL3F5Yzkyb3g0VCta?=
 =?utf-8?B?bU9vWmpsdmoxWld6WlI3L3p1ajBiNGZhUkpDUkREQjBTdklBYjdiWWE3Z2Jr?=
 =?utf-8?B?Q281RDhFbEFmcDMyWE5TQWRyUk9KUVU0MVRNWDJwSkVMNnVoWS82Mjg4UDFH?=
 =?utf-8?B?UEFrZGhjWVVVUUVZVjBSOHA2QkZabDJIbjVteDNSdEc3YTQzazkvMEJKNDRy?=
 =?utf-8?B?YVowVVdPWWVSeU9Sc1UxQ1BJYTc1Zk1FR2hIb3JIQmVIZGFrSTFBZEg4VTFx?=
 =?utf-8?B?UHNhTzJJcDR2SFFWSmVubGdMaTVjWkQ3K2NUY0JxWUNCb0F3WGNXemRFVFNV?=
 =?utf-8?B?VmJEQTZDRUt0WVUxMHl6eElNTkdIZHFNZXQ3TUtOVWhEdE5JZ1Z2VVN1TFVS?=
 =?utf-8?B?SUZmNUcyZVVNRGt4NkZLSUdnUFlOMnVoT09JZWFhMk0wYjlUZFMzSXZ0WUlZ?=
 =?utf-8?B?QnFlTVl6eFM3Z2VUOFNRamxSVWdJNlBlNEg0U05mRHFCY1R5RHFMVGRxZlQ5?=
 =?utf-8?B?WWVIN0EzQkFOeFFoYXFEZkt2cGs1eUt5U0dnbUt4YzNqMVpVN2NoRU1ORTIz?=
 =?utf-8?B?U0ZlcmlMMDVPQ2tneWY4RGtqUHJtdkFvUVRLTXcyL0ZrYm54T1p2MDF3Y3gw?=
 =?utf-8?B?QW51NVJnTkRLYXZCUHJKNzhTMXBUTXZpbHFoeTNUaUUxVnRCa1hrZHR5eHB3?=
 =?utf-8?B?WC85N250bnBlV1NxNHo5a09sbnhHSjhIbUl1eUcrYXVSVDhlbXNnZGRCUHph?=
 =?utf-8?B?RHJRajJEN2ozSjF1c2lhY1ROOVBoYld6cm9RY1FSWDRjejJNNktwUDR0VnRa?=
 =?utf-8?B?S0NnRlV1WG00UWFRQ1JlcHU2ZjFQVWVDRXMwa1U1eGZvMHc0KzdQR2JsTG1R?=
 =?utf-8?B?enErdzAvcVVvMFhmUG1CSWY3bmVWSmxkUmZnR2NudzZ2M0tvVW0yMUkxbS9W?=
 =?utf-8?B?QlVaZUVtcTBFUnJGTXRGYmxSaThmOVNuTmgvUnhGVW9KOWlOd3M2VHhnSU0w?=
 =?utf-8?B?WXdlbzM4WjY4MFJ5YWFzcm81QmpXZ0FRL1ZtU2dabExvc294WVhFdWFtamJm?=
 =?utf-8?B?MVNLTHF2T0xLUTkwSWREbGwrZ3FjK04wRGhWaFVZUUxuQ0pjS0RsSTJzNlNS?=
 =?utf-8?B?WGRhY05VWGE5Y1RVNy9kQ1pjYWNCTnZFTFBpMHRLSnhMZkVKT0FocmIrL1B0?=
 =?utf-8?B?ZytpbW0wVFZqaUc0aFZMUXFmZ2JKY00wOEY4Y3g3UDhIUnJWMTFwelBWaU1K?=
 =?utf-8?B?UjA0aWtrSXM3RittYjdFRjd4SnFYZTdhdEdsS3R2Q0xhM0xVRFFOblNYZDYw?=
 =?utf-8?B?aDM5VUFObTFsT1c0SmYwY3EzVXBKYWRUS3NhTmUrcHl3ck5LUnI3SW90WHB5?=
 =?utf-8?B?UjBKU2VVZEowb3RyeUdIY243ekdKS2V2S2ZQcnJFNTlrQ01SeElNS2I1N0x0?=
 =?utf-8?B?U0xkOFVtdEJpZnBMdi85TkJsNmtnM1FDTUQyS3g3ank2bGlFcnRKWDM4RXE5?=
 =?utf-8?Q?8+7qgNrfLWc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXliMmJSSlkyR1crUngyR2RqbS9Pa0VUVjFkTTdjU3BUYmtuK2RjUkFJcmZ6?=
 =?utf-8?B?N0lLa0g0VE9udzluQXdxTmdDRjlPcVZ3UjJwbDl5ejkvMmFWUDBKQXpjN1NY?=
 =?utf-8?B?U2pJWXZLK2hoOTdQQjU0QTlwS2lUNFM2Y2hNM0xsR3B3cWNVakpseDhlV2U3?=
 =?utf-8?B?TWNjN2lsaEpOaUVodXJjSk9XRTRmQW1xZXBjNytyc0JJTm05b0dQOEF5aVF2?=
 =?utf-8?B?bmJDbUNvUmFMOWRBNDlXVEFVVEFGWHAwckp3WjFJZ0pmeDhtUTNLaEVsUXVI?=
 =?utf-8?B?MTZNeHprWFlFQkxlbm9TbzdLeFpHQy9OQVlXakhSVW1uTmp2TVFTMGVlOEo1?=
 =?utf-8?B?OXRsSEJPYkJMQ2xpOU4xMWREK25vSXZYQ1lJOUJ2bzdBQkdzZEQ1eWZLTFgx?=
 =?utf-8?B?NXg2TllxQzdyOFlqUW9uMkRMazk0cXBrdUJWNWhhR3FGK1poM05xQjhmOUdG?=
 =?utf-8?B?ZS9sNXh3d3greEp3SWxSY1g0bXR1Uys2cTBvNk1TbkJVRkNmTEg1OHcxUlQ3?=
 =?utf-8?B?dzU2Vm1rM2M0RjJ0TWtWblJsdk0xb2IvRnVXM2ZJQjdlblNKZGNnNE45RGNz?=
 =?utf-8?B?OEp4QjU4K0Z5OHdUb3M3UGtuWFM3ckk5dnBtOE44SG00bkp6b0R2dGlUYWIv?=
 =?utf-8?B?OFlYYkhlU0RWZ3A5Q0o1bHo0blZGYkhmeVlhRkxMT2VTdFNzdVp5NVVHd3BR?=
 =?utf-8?B?Sk9TTnUvM0t4Yk9aOUlFcm9LK0xRbjJvY2JiKzdqUDVWbHltY2hNODMyejRZ?=
 =?utf-8?B?cVVaUDdvVi80VjIzOGQzbGYvUVI5RVpKbnM3TEVEUzVZT2hKZDQ1T3crZG4v?=
 =?utf-8?B?ak9sVWNXNHdHMDlzeU5id00yNC95QW5FK1JIY1BTY3VLOUdhVWFjemtmREpZ?=
 =?utf-8?B?QmNxN0RETGZzckROQUZweG9zYXpjakV0U2pEVGNLemtoaHJSek8wbG43TEFv?=
 =?utf-8?B?a3o2OHFiRHFiUk5ZTUJwbEtpQkJHMGY2by93ZWhKdEpLM2tGaXVVaXFzUGls?=
 =?utf-8?B?MG1BTm5yYVgvRm43TWNOQUxxbnJhcTNSS3lRNldNNEduNDNVcGRFazNsTk9o?=
 =?utf-8?B?TUF4MnFPREdoYkR6ZTNveHVhUC80eHU3OHJ1Mkk3K1pGWXIvTUlIbFFjTFRw?=
 =?utf-8?B?bW9Bc3BWYzVNS2ZDMkIyZEEwaVZ5c0lRYzJMOE5IR3FZOHdwZXkvN1lxZStO?=
 =?utf-8?B?eUM0c3BSRjlPYSt6R1VrRW9naXRPVHJYNnpqRDBRRzZRMnF3YndVcWlKZGpt?=
 =?utf-8?B?RTBTM0pIbUNxdnF4K0dRUjBJYmE1NGthbzRxUGtGemlGR1hneE9DL1NKYTdV?=
 =?utf-8?B?aVNwQWx0Rk1mV2NUWGJaZDY4dEN6QzFYWVJWbkxialZQZXgxRWJGalM2UjdR?=
 =?utf-8?B?bDlVNzZzZjFWd2ZsekpZc1IwMVNoOXB1dUxtMzR4ZVltQ0M2dUNjM29HM1Ji?=
 =?utf-8?B?L2puc1h1emNiNWhYQ080OTJVUitPaUZmcm9weGJUc3lOeWptTmV1OHIyUkRV?=
 =?utf-8?B?d1p4MSt2cFBkYUFnYndubHA3VUc3QjJTOXhjWU5adzEvdHhOZ2RQTmpWbGxP?=
 =?utf-8?B?U2FKZnZ4ZUNPYnliV0pQbjkvL0t3VEdMTUh2TjJuejg0OFFIZ0Rjdk83V0NZ?=
 =?utf-8?B?d2lNSVVzL1RCQlZCNDBtNVUvYWtCWjZsQ0liZTZhZHRIL3hwdWcyTXVMd2pR?=
 =?utf-8?B?bzVMazkxbDN3K0hlY2JhN1NIdm1leU52SUE3clRhdUczUUdLeGpQWmxFdXRa?=
 =?utf-8?B?aHkvd3BxM3V2RHBVa2JNeEpUeXcxc2RKMmpEdWZVUzUzN0pNblVNcW5vNUJQ?=
 =?utf-8?B?Wk9NNUxVTGxkU2VBVlVtTkJjUGJaNk10b3pXbGp4NndJWThoK0pwUHBIb2xk?=
 =?utf-8?B?RkxGNGJwbWQxNEttdDA2ZWZVOEFmeEFDRXlwWnJFdjh5K0YwUDFuZFUwT3NU?=
 =?utf-8?B?YTY1RHFxdXFpSnZodHVFc2NucUdNU25GMzdvZlgwQ1Erb3FPZkFoOTZNNzhS?=
 =?utf-8?B?eW41Q0NHVHdONTZBa2dkTlVRa1N4akxQTm85MU9IVXZwRUxyOG13UGNNT0gx?=
 =?utf-8?B?VkVSQ2YvdkNKODViUWJaODFYdGJCamRrazh3UHEzOWdXNWpQeEYvc2hmcC9W?=
 =?utf-8?B?Uy9LM3BZaUVsM1diYWN4dGJsQ2JtVlp4THpiMjhHTlZBL00zbWMvRldKUkp2?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IkWf+Rv/B5waRzw7suDQ4s/IvlAQfbHLvDcS8IWl1yGJnFvJjvLnOVBvdLrID4pRZiq7diEGVzXlhJsl/HECth5Da0T52RfTc7hlMFheQsO3T1duT6sepacRfZhV9YD1XO8GpB1O+k6NlTs9vSKj1Hrr0qziK9Rho1z6l3q1qb5QAslv8HDHm8gKjjr2QbmgFMNFzHbkaKCgzqWnYdyWGOEliDfz9iTWyt7DskrUic2wgHP5m25qdzrGVSkQbUHy2NcyPWh3YuQkNroF015FIcd5+wkWNcuLR/4P9ClQC/9XsyUyR/CEUhBLkOicVzlT6QPnT5MVcAtZYnXFTaqKiFyR87B+ShDEGC+2fTDHVPWtSm4glDx6zTWSu/T0o/yWn/VxiOXldSLWphAnTvFMhRrboOLLTBLZow4c9P/Pf20Ev9gR+kB3upxB+dyDLA1SkXUq6fVJt3Xlj+bJKlhFxnVv8ZbJvr46txz3kV7WetlcDzep5Sm53+p/Ko9hblQ+B+DvYxlBq5gve0VlzvVFrw8Nz/wU0e0SS3ETWJLfRczGvJsTYchpe8noQ5178S44lDwpD79WemuyM9zd/BLt0a0t18Gksxr6mNK7Poh6e3c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001a0c1d-cc18-4458-adc0-08ddb8ba1e60
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 16:12:47.4489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UVpCmlgBYnQTt3CB8Gkf9JS7YZCDkUzSREdsjf+Ksxj3wIwFV5nRtjRVFK/L/jUN0nz3N6Xn1CZ4Qb2Lwrwxv5m+H0xOGh473Le2CSkWvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010109
X-Proofpoint-GUID: awcKhMmVROejxtAbc6HzZ2Og1EsZxPqI
X-Proofpoint-ORIG-GUID: awcKhMmVROejxtAbc6HzZ2Og1EsZxPqI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDEwOSBTYWx0ZWRfX9DfZG/4w2H5E
 bYe7s2ezEB8gu7MV6TZ6cZwyYWvwhzL4BQcKlJdCgYg7TkXHDMha/Vz0g0UBTZ1siIb/RSzwOvT
 VbKrjwkX3BVftPzaNAXgUnuNAQd5ehd2PWBLsDxGezbDK01zwCZQTsZXs6yqsJuXbUZEWOfcUHK
 h9O88EiLsW5cVt31vsNf8Hlai1OjC4PWNTUAS6VdKnghc/gb1mXa6B464K0lsrdCuLoKeA1GwMA
 243u/rb0yC/yvklrjdJJiXil8osaD1b2mOlWYmQCzq7mAhqJWSueDIlnCVxBM6lZ2qCvK0yQvmv
 ncMos1nCELzrlrvtPfRw0pc3YxSt6F3tIgpLrYRQr/j03LY6cTFCOOi7RsEyQuJE6Y8UW4pJp+1
 2Jc2+zztJJzhoQww8RBHIRS0UOkQrGjPGNcLgY+HiVNagkGGBCMsLd9ew9A+2g9TUGwveOEI
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=68640904 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=fxwbUNYKkYGBfChAX9UA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13215
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Hi Cedric, what do we need to do to get this patch in, and the patch "preserve INTx"?
Just review, or are there conflicts to resolve?

- Steve

On 6/10/2025 11:39 AM, Steve Sistare wrote:
> Save the MSI message area as part of vfio-pci vmstate, and preserve the
> interrupt and notifier eventfd's.  migrate_incoming loads the MSI data,
> then the vfio-pci post_load handler finds the eventfds in CPR state,
> rebuilds vector data structures, and attaches the interrupts to the new
> KVM instance.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/pci.h              |  2 +
>   include/hw/vfio/vfio-cpr.h |  8 ++++
>   hw/vfio/cpr.c              | 97 ++++++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/pci.c              | 54 ++++++++++++++++++++++++--
>   4 files changed, 158 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 6e4840d..4d1203c 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -217,6 +217,8 @@ void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>   void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
>   void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
>   bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev);
> +void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr);
>   
>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
>   void vfio_pci_write_config(PCIDevice *pdev,
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index 8bf85b9..25e74ee 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -15,6 +15,7 @@
>   struct VFIOContainer;
>   struct VFIOContainerBase;
>   struct VFIOGroup;
> +struct VFIOPCIDevice;
>   
>   typedef struct VFIOContainerCPR {
>       Error *blocker;
> @@ -52,6 +53,13 @@ void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
>   bool vfio_cpr_ram_discard_register_listener(
>       struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>   
> +void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
> +                             int nr, int fd);
> +int vfio_cpr_load_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
> +                            int nr);
> +void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
> +                               int nr);
> +
>   extern const VMStateDescription vfio_cpr_pci_vmstate;
>   
>   #endif /* HW_VFIO_VFIO_CPR_H */
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index fdbb58e..e467373 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -9,6 +9,8 @@
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/vfio-cpr.h"
>   #include "hw/vfio/pci.h"
> +#include "hw/pci/msix.h"
> +#include "hw/pci/msi.h"
>   #include "migration/cpr.h"
>   #include "qapi/error.h"
>   #include "system/runstate.h"
> @@ -40,6 +42,69 @@ void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
>       migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>   }
>   
> +#define STRDUP_VECTOR_FD_NAME(vdev, name)   \
> +    g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
> +
> +void vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
> +                             int fd)
> +{
> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
> +    cpr_save_fd(fdname, nr, fd);
> +}
> +
> +int vfio_cpr_load_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
> +{
> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
> +    return cpr_find_fd(fdname, nr);
> +}
> +
> +void vfio_cpr_delete_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
> +{
> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
> +    cpr_delete_fd(fdname, nr);
> +}
> +
> +static void vfio_cpr_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors,
> +                                   bool msix)
> +{
> +    int i, fd;
> +    bool pending = false;
> +    PCIDevice *pdev = &vdev->pdev;
> +
> +    vdev->nr_vectors = nr_vectors;
> +    vdev->msi_vectors = g_new0(VFIOMSIVector, nr_vectors);
> +    vdev->interrupt = msix ? VFIO_INT_MSIX : VFIO_INT_MSI;
> +
> +    vfio_pci_prepare_kvm_msi_virq_batch(vdev);
> +
> +    for (i = 0; i < nr_vectors; i++) {
> +        VFIOMSIVector *vector = &vdev->msi_vectors[i];
> +
> +        fd = vfio_cpr_load_vector_fd(vdev, "interrupt", i);
> +        if (fd >= 0) {
> +            vfio_pci_vector_init(vdev, i);
> +            vfio_pci_msi_set_handler(vdev, i);
> +        }
> +
> +        if (vfio_cpr_load_vector_fd(vdev, "kvm_interrupt", i) >= 0) {
> +            vfio_pci_add_kvm_msi_virq(vdev, vector, i, msix);
> +        } else {
> +            vdev->msi_vectors[i].virq = -1;
> +        }
> +
> +        if (msix && msix_is_pending(pdev, i) && msix_is_masked(pdev, i)) {
> +            set_bit(i, vdev->msix->pending);
> +            pending = true;
> +        }
> +    }
> +
> +    vfio_pci_commit_kvm_msi_virq_batch(vdev);
> +
> +    if (msix) {
> +        memory_region_set_enabled(&pdev->msix_pba_mmio, pending);
> +    }
> +}
> +
>   /*
>    * The kernel may change non-emulated config bits.  Exclude them from the
>    * changed-bits check in get_pci_config_device.
> @@ -58,13 +123,45 @@ static int vfio_cpr_pci_pre_load(void *opaque)
>       return 0;
>   }
>   
> +static int vfio_cpr_pci_post_load(void *opaque, int version_id)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +    PCIDevice *pdev = &vdev->pdev;
> +    int nr_vectors;
> +
> +    if (msix_enabled(pdev)) {
> +        vfio_pci_msix_set_notifiers(vdev);
> +        nr_vectors = vdev->msix->entries;
> +        vfio_cpr_claim_vectors(vdev, nr_vectors, true);
> +
> +    } else if (msi_enabled(pdev)) {
> +        nr_vectors = msi_nr_vectors_allocated(pdev);
> +        vfio_cpr_claim_vectors(vdev, nr_vectors, false);
> +
> +    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
> +        g_assert_not_reached();      /* completed in a subsequent patch */
> +    }
> +
> +    return 0;
> +}
> +
> +static bool pci_msix_present(void *opaque, int version_id)
> +{
> +    PCIDevice *pdev = opaque;
> +
> +    return msix_present(pdev);
> +}
> +
>   const VMStateDescription vfio_cpr_pci_vmstate = {
>       .name = "vfio-cpr-pci",
>       .version_id = 0,
>       .minimum_version_id = 0,
>       .pre_load = vfio_cpr_pci_pre_load,
> +    .post_load = vfio_cpr_pci_post_load,
>       .needed = cpr_incoming_needed,
>       .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
> +        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, pci_msix_present),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 4cda6dc..b3dbb84 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -29,6 +29,7 @@
>   #include "hw/pci/pci_bridge.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-properties-system.h"
> +#include "hw/vfio/vfio-cpr.h"
>   #include "migration/vmstate.h"
>   #include "migration/cpr.h"
>   #include "qobject/qdict.h"
> @@ -57,13 +58,25 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>   static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>   static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
>   
> +/* Create new or reuse existing eventfd */
>   static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>                                  const char *name, int nr, Error **errp)
>   {
> -    int ret = event_notifier_init(e, 0);
> +    int fd = vfio_cpr_load_vector_fd(vdev, name, nr);
> +    int ret = 0;
>   
> -    if (ret) {
> -        error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
> +    if (fd >= 0) {
> +        event_notifier_init_fd(e, fd);
> +    } else {
> +        ret = event_notifier_init(e, 0);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
> +        } else {
> +            fd = event_notifier_get_fd(e);
> +            if (fd >= 0) {
> +                vfio_cpr_save_vector_fd(vdev, name, nr, fd);
> +            }
> +        }
>       }
>       return !ret;
>   }
> @@ -71,6 +84,7 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>   static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
>                                     const char *name, int nr)
>   {
> +    vfio_cpr_delete_vector_fd(vdev, name, nr);
>       event_notifier_cleanup(e);
>   }
>   
> @@ -394,6 +408,14 @@ static void vfio_msi_interrupt(void *opaque)
>       notify(&vdev->pdev, nr);
>   }
>   
> +void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr)
> +{
> +    VFIOMSIVector *vector = &vdev->msi_vectors[nr];
> +    int fd = event_notifier_get_fd(&vector->interrupt);
> +
> +    qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
> +}
> +
>   /*
>    * Get MSI-X enabled, but no vector enabled, by setting vector 0 with an invalid
>    * fd to kernel.
> @@ -580,6 +602,15 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>       int ret;
>       bool resizing = !!(vdev->nr_vectors < nr + 1);
>   
> +    /*
> +     * Ignore the callback from msix_set_vector_notifiers during resume.
> +     * The necessary subset of these actions is called from
> +     * vfio_cpr_claim_vectors during post load.
> +     */
> +    if (cpr_is_incoming()) {
> +        return 0;
> +    }
> +
>       trace_vfio_msix_vector_do_use(vdev->vbasedev.name, nr);
>   
>       vector = &vdev->msi_vectors[nr];
> @@ -686,6 +717,12 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>       }
>   }
>   
> +void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev)
> +{
> +    msix_set_vector_notifiers(&vdev->pdev, vfio_msix_vector_use,
> +                              vfio_msix_vector_release, NULL);
> +}
> +
>   void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>   {
>       assert(!vdev->defer_kvm_irq_routing);
> @@ -2962,6 +2999,11 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>       fd = event_notifier_get_fd(&vdev->err_notifier);
>       qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
>   
> +    /* Do not alter irq_signaling during vfio_realize for cpr */
> +    if (cpr_is_incoming()) {
> +        return;
> +    }
> +
>       if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
>                                          VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> @@ -3029,6 +3071,12 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>       fd = event_notifier_get_fd(&vdev->req_notifier);
>       qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
>   
> +    /* Do not alter irq_signaling during vfio_realize for cpr */
> +    if (cpr_is_incoming()) {
> +        vdev->req_enabled = true;
> +        return;
> +    }
> +
>       if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
>                                          VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);


