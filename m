Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB36C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uix1X-0004Mn-5n; Mon, 04 Aug 2025 11:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uivj3-0000tg-Qq
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:59:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uiviy-0004lW-1R
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:59:41 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D6WbY018172;
 Mon, 4 Aug 2025 13:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=zejkgzJBd/pISZkEZlK5z/Zl20twcLeVclpZNpb+nTY=; b=
 cVW2WypFJhkCJY3EWxX4w/Gq7KIjizoQjnWHgvF+4oMKjhx/qDon5YRqkXueeM31
 o8tfFCeiNb/wFzgfsU3rRVAa9NFBDeKDv0vN8jcdvekyFG3WWYqTR67M/BnSAGWW
 QqmhiS4tUpbPDG2yYFIsUJbLp41wXae31RU9hZm63kfi+AS0GJ4nCYlFdIZLMIXL
 anqQYm4ZA4XSR9CSqX9cwZT0teN5A1tabwFiFyPucgGDdcF6mmscXFv4Bu2BGr8T
 mXZWvnzL7xqJtqKzvW/Yc9aYbMSsDT3ggksUndMKc/b4DsALhrf7ydU/VCrKsrB9
 ZG520UW63fPtnKWK849y9A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489aqfjn8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Aug 2025 13:59:28 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 574D1oRH032007; Mon, 4 Aug 2025 13:59:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48a7jun6yx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Aug 2025 13:59:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1TKRQ+v/4FVRm8mWAPTfHTA8yRS6zndlBlVb7+twrQ81pSiJDezm2qXLrC9fj+2auo09zopzhAKG6ls3aK5n2nl+/XxdeODJ7e/ws144K7PSnt2jkGxjHyy3OL7jJnUiPSvvjurafsS6rJ2t9VKYk+Ihs0NIGLqA02eifIIn6Diro087ICHK0LJNfZdCwcNfZ2TxZOw9hogfjYs6Kja95CLTKrisZjqYZoUWMDapXQSK6B7mpuoQZN9dQ0DNpO2GoESr5g4yrCNZIa/TUcXlWKksBqjc3enggIWNXcncK4wbM7gEeNiyjd2p3BWiO4IkjSdv6hwNT3HxXUxBzvVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zejkgzJBd/pISZkEZlK5z/Zl20twcLeVclpZNpb+nTY=;
 b=X2aId8Gz2oEzmXh/gZX7SQuwDPVaoZt3ea/xXkLmAT2lMwfsRnrLuQ7yl2hPqdXic8MV23t9SsR4PBlOSPFGnxndnBrN1vfB+HMzQnhSnQqy8pEf3746WHoRigSUxrAJGN9Y4RA7P7gZG7GecVKAKJ+QvJD/lJWC8TRJrgHFr3fnXtJeS44Tq/rxHxH7NkfdQrKb/0RLKl4v4Zvug8NS973TXHA2tnWui11WWmkN/GzqEhxptFSHYvwSXNekNQEdjJtadACiHwtDsvhQzuKXTMWqOHYBSvOJthnlmoZrxjqaa4sss2NlP/7K8VDVE9Xk00qDjWIBLfrsQawT6qSMrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zejkgzJBd/pISZkEZlK5z/Zl20twcLeVclpZNpb+nTY=;
 b=hXRkVMg3Lm7HnQcfygcMFvWyMxlAFRAjnPrlqlo/9SOjb/4bBEhbZGqu7PNv9P1mHNPGc/oqxyIe7CfaU5LsV2I6VOjSFKJhu4TA6UOUJCb69qP9Ye8zP7vU92fpZYyexHF12FNljNePZximJkLvGUEvNuXh4iGCBHz+vpERAOQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA2PR10MB4713.namprd10.prod.outlook.com (2603:10b6:806:11d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 13:59:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 13:59:24 +0000
Message-ID: <ff871c80-2931-448f-99ee-085fec5cad0e@oracle.com>
Date: Mon, 4 Aug 2025 09:59:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <1752689169-233452-1-git-send-email-steven.sistare@oracle.com>
 <1752689169-233452-3-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB91361BAC8208FB1B7C929E9C9251A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <1713856e-232d-4d15-b13b-23c2bcdb3c34@oracle.com>
 <IA3PR11MB9136C681984E6880B270CC04925DA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <eb8f4a1d-aec7-4747-90dd-c869a8dd3a40@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <eb8f4a1d-aec7-4747-90dd-c869a8dd3a40@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0080.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::23) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA2PR10MB4713:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d23695-a7c2-49ef-f997-08ddd35f1e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z250ZlExdk5BL0JKcXJ0WllpemZtaGVHdVM2UmpINjZyK0QrVmI2MVFLNGg5?=
 =?utf-8?B?MUU5KzMraGZqTnBEcllyV29XV2RFSlBuYXV6ZVU3bmdEQ0Y0TncydGl5OWN1?=
 =?utf-8?B?cWFObmFUcjJHTU5IelVxTHA0Tm1pNVBtSW1keVFydkN2WXlaNXFHMTl6dnRs?=
 =?utf-8?B?dE5sNXIrcDFRWkI3ajFRTTBDNk85Nno0dmt2THkrc0RTejRqVGhoUG5BY2R1?=
 =?utf-8?B?ZE1uSFlvWkJmVU9xRC9odGtrNXNVeEVYTW5GSnFyNktJdCtzRjl1emUxTkNW?=
 =?utf-8?B?V3ZUVVh0eVF4by9KSGxlTkhjZ25NaEVyMkpIWnhTc2RIMVRYaFo1MXM4R3Q0?=
 =?utf-8?B?SjZHS3BDdjVtdXdzZTRQZkpHZ0ZhSU9KU3k3dzJtRmNjWGZrTWFlaE9kMkhX?=
 =?utf-8?B?akxDaXBKRlhLL2ZCSS96dkZVMytSemxiNXA5cnFRcHQ3c1NoYVNyMkQ4NHR1?=
 =?utf-8?B?aG9XQldoTnJIVTBOdVVsNkZIdUJta25URms5Y2hCbHN3eWE2U0U5RW54S3VN?=
 =?utf-8?B?MEFLRERnVncvbU1Vdmk3OUl2V3NGd1pGZVpwMGJkUnRuNjJ0a0hta0lTQnlq?=
 =?utf-8?B?cTVuVm5GWDJldmVNaVRLMGpVTlZiSVk5MkwxZ3FNTDRyU0NrZ2ZVekJ5c0Nq?=
 =?utf-8?B?MG1MeXd4ZjJFNmJKcWllZk1TRlYxUTAvakxzMWRrcTN0RjlBTkk1aS9Ra3Ju?=
 =?utf-8?B?STE3TkFZSkt4dVNVeEV5cVdjUTh0cXpuQkUxUkdLc2NkUzhvdDgyS2VtUllU?=
 =?utf-8?B?T2ZRNFNrV1d1ek9Qbk5sVUlQcEZBd1ZmNWJoRlBaRTkzdGZoejczYmc5ZUhl?=
 =?utf-8?B?VkRaRmJ1TXN0bk1takxZWG1JcW43eW5Xb3hSUWh6Q29GQzBCSDdNZDZ1M0E0?=
 =?utf-8?B?QXh0dmZQcVN5U3ZDUFRhVEtrVis1N3VYUWNyZ3dGRFNOTFFJL1V6VWFvc2xl?=
 =?utf-8?B?QkxWSGhjejdEQlRxcHFnenEwR1JuZVJwc3pUUHFkVHFERzVYbzJBbWpKOHJu?=
 =?utf-8?B?cmg0RzVZOWl4VGRQeHJncjdxNlYxTUlqT0NhZGo3VldnS3VmNzZ6eFJITmNV?=
 =?utf-8?B?cDRYaDdvaUZsVG1GNkh5UDBrbzY3RmRJVzc0WTNxeElZaWdNVUgzVlZXOUxk?=
 =?utf-8?B?bDhyaXlyNFRrU3BGTHBUazVFQTQrT1ZVS0k2akRRS2NnbjlxY3d5WndWbzEv?=
 =?utf-8?B?dUtia3JuelYxbXpMeGRIOU9pZFdJMkpPUE5MNzFLem1SZG82TmVyTHRvZ0c2?=
 =?utf-8?B?WHhrQWdCNTBSeDRyUExIRWdDNmtPaFdCRng3MXBjZTc2QlVSRHZGdzRmb1V0?=
 =?utf-8?B?TDV6ay9KZkhqQkpGS3FLQ2pQekhJNTdPeS8zY29qbHJJemVoYnNyeWp1dnBH?=
 =?utf-8?B?a0VzMnAxdEw0TVNkTzhrY1YxVWJ0WXhvMHhqYWlEYkx2QUQvZTFGZVI5MnRp?=
 =?utf-8?B?ZHp3VEFMV0w2L1o4ZTBQTGF6L3F4VzB2RmRPYVNBT2o0RWhweGErOHV0U010?=
 =?utf-8?B?d0ViWDlGZnhmb2VZQ1FhTy9xZmljckpJUDE0bVZuWTFzOCtINm42TlRCQWZ3?=
 =?utf-8?B?ZTljWCtDSlZ4eXpTeEhRQytwRXhTNnIwbDMxcWc5SHdKQmZCejNBeDQreEo1?=
 =?utf-8?B?Vk11M3VmeXRSWkpUaFhSSWhyVk5nUDE4YjhBMkpYR1U0SzFRVENyYkZJQi91?=
 =?utf-8?B?Mms1Mm5VZWU0MTdtOUN0RWl3dHdWRTU3MU5wcXVFc3pqRzZmclhBb3ZIYnF3?=
 =?utf-8?B?NEJaUUhQZ1JrSm1KUjRZYU9Da20vUHFUK05kK0o3ZXlZZS9saXk5a0FTelhx?=
 =?utf-8?B?blJXM1JibzFCekppdGtkNzM5NUt4Y0xlRU15c1M0TkcyM1RsNVFpbVNXVG1t?=
 =?utf-8?B?RTFVdUh5OFRJbVBPaE1vSnR6MWkrKzNQNUorR0NJaUsvNkFjc1g2ejg5cnJW?=
 =?utf-8?Q?5FNe1lLZmDg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWpGeFN4OWRxaDNXWUdqOGNkK1k2VUJNaEk1KzA0aWRyT0lHRjFXdlNOSFBL?=
 =?utf-8?B?NDRleElpNEM1cEI2TDN4SVJBbi9MT3hoNDYvVllzS1FxZFlGYlFHQmtuN25Q?=
 =?utf-8?B?VWJzc0Q0ZHlGQ3FlVkVrZUJHUTQ1MFJQLytkWHZOWlo0VWxnemJtdFFHZURh?=
 =?utf-8?B?SlBUWVNQMzlMWjlSeWhkOEpUd2FrOWVGeVZYR0JGN2RhenJXeUtIcTN3RHN0?=
 =?utf-8?B?UFJ4TmliaGZUVEdITVRXaEVncmdZY0RHMHplSDdNZEVOMEJSWjZQdTA2WkpO?=
 =?utf-8?B?Z2ZVUVFaMTR3aUNEQ2MzTDZpL0ZCTjdhcmVLZkNpQm4vQVV6cGxpWndvQXRN?=
 =?utf-8?B?MU1QdXFLSzVHN09sK0FXT3FkRjdmOUQ0SzJZMUEwQVdPSXBmeGVpTTFvSnhS?=
 =?utf-8?B?RmdzaXFndkJJNENIQmt2VVRwdzlMcjljcmNna3JtcEhMWXFJK1F5TVAvbFNC?=
 =?utf-8?B?K1lGakhXTHlHTTlkUmswclVKSWJjT21IbFdTWEYzOEZWL0JtTXBjZkFhN0di?=
 =?utf-8?B?QkFlT1NDKytqUlBVNGVqNVpWVU5DWm93cHI3ejJNS09zeUtQRzVmY01Rb3R5?=
 =?utf-8?B?MTBDR2xkNmN3QUFJRXIzdDlqVFl6dVFnQmEvWGFQNFErUlVaMGtHNVExb00w?=
 =?utf-8?B?QzhkY25UQitqQnJBekNrb1J6VnRKL2xmTG9mVUwwYjBDQTlScEJyTkZDY3A5?=
 =?utf-8?B?cVF6V25kWTZISmQ4d1cxOVBIa0VYMm1XS2hPTXRHT1RPeHVIckpPK3d3Y1pS?=
 =?utf-8?B?MjJmaTV3ZXl4bjdwS1dkYms0MkNXb1RkUU5WT2hXaTVaU3F4bTRpektJdFUx?=
 =?utf-8?B?YTdzL1dNWXVUUGNmWkttZmVGVTExM05RMjFJaklBN3JJS2VSMTlLbmZxMis2?=
 =?utf-8?B?T0pzMWdUWVpXWDRyc0xoUlhJS3FkckVkSWV4cTB5Q0xNd0NXMlNOM0xlL1Ft?=
 =?utf-8?B?QjcyUndGUXdQWVExQ2RoaTNiREhaUExwcUdxVFUzOGpLTktFNm9HdlpPTmVi?=
 =?utf-8?B?ODgrTFBULzdKa1U4dExyQXpqMWZHRlkxait1R3d1SFBHZnhxYlNSS21odWND?=
 =?utf-8?B?THpXYlpMT2p2R3BsSHFkUTVBYXRBenFBUTlwSmdYM1k0b2c2UGhvNkR3M0ht?=
 =?utf-8?B?djhTK1ZhYXdySDZnT2VxbC9Jc3Z1R0dVY3A4Vy8wc2x6d09XS1U1aXVoeXhV?=
 =?utf-8?B?emVxZ0dXZjFqYUZQN2Nsa2JWY0tLVm1panRvTkVJclJ0SHJWQUlCVWdzeGFx?=
 =?utf-8?B?OSt0Z2psRTB1MlkvcDMwblkxNW9XVVNDMzdMd3dtU2toTmluZUNkVkEyWUxB?=
 =?utf-8?B?ekFEK3hoOXBYeG1EZ2NndWR1NmZ4RTYxWUEyNXN3K3JEUWtZekRpMENzSkNn?=
 =?utf-8?B?TkJMcjN5M0ZuYmFuckZ0b1RJc1FFbzg1MDUrMjRpRlMzMVBXYTBZVzl3cld6?=
 =?utf-8?B?N0tmbElZMFR6RldBcXVSUld4cEtNdksxZlhUWGpFTFRNbTZuS3gwejUvVGg3?=
 =?utf-8?B?UEdaR3JPdWlrQ3BxYW5UY2FyYVBHZ1Y5Nkx4OVBxUGhqWHgwSHpLUzBtY1dC?=
 =?utf-8?B?K3pEOHg3UTVQZEJMRlZ1c2NNd3dnRlFxY0M1SW9CNytJYWREOGNGaVBHRTgy?=
 =?utf-8?B?ajJJSGxBc2EvRFlLZ1ZmcFRhaGh3MnJvNDN0b1ZiVDdRTU0vZkoyN0FxZ3FQ?=
 =?utf-8?B?ZGhzM05MV1hhQjQySjY0VFlPOExVZllNY3BpbmhMbklMczZwdWgzb1M0M1Q3?=
 =?utf-8?B?QVp4WWRDM2kyaFlmMkI0eDJLcjQ0VG1MNG1vYkZGZ0RJZUk4bGd3eERDOVpL?=
 =?utf-8?B?NTQrY3JvUEdpdTJ5Y2hVSGp3MGhiODJhNGxWcHdxTE1NNjdzNHFyRi9iUzNK?=
 =?utf-8?B?bDhjMmVJWkdwNVBJMzhKbVZ1S1BLN2w5bGpudTNMcG1WS2k0SG5lQTBCQ1VQ?=
 =?utf-8?B?dVBsSngvTjhLUEdkZ1ErOFdxd2Y1eDhxb2lEcEY0cG1hY292UzRSd3NyQVNN?=
 =?utf-8?B?TTFhQnllYWpkWm1lUW5tdFFhd2pDaFZmOUN3R3JDWERSSGFpWG9ucWtRQTNp?=
 =?utf-8?B?bEJPdkNoWTVmUDQweEtqL2N1ZWlMNXF2NStXQ2h5eXpNUlAxbEE1VVNYcTZE?=
 =?utf-8?B?bi9BVjJyYnJYOVZQVEJMTktnUzBrQUZvRmV2NTgySUV2WWE0NEpETVVuYnJV?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mW7oZgYqZcegIOQwVpEihYcNpDdHrql3774twzBMBUkvPRhn2p5e7Sg7bPdMcxjB9XNzR9n/FFmFJm/9trU+03uwqMqNWMsvsfc2YsXN+dUZCX5v2Uq1rTbzFW3iHz9zhZhXRAiZerGetaaDwNd9xX5BsJaE6oraHIZ6fU8z5lzI6rKWg+P5KiSxyTA/Zpiy94idNWj9gWm9UgZ8WGSdImextWsHbYShpDKBFH77hKr9bEdWF0MDwC8ReKMeoyner5vHivGbkhX8Yfjw0OAMdKCNR6jPnXhaj1Q7lvTspkHuLAo2vyu8QyV/OsVYlSYd2MR+5mOB7MCwc7RSee7tDbfv7DoakSRAmraIcnG4d80Z6OoEAEAOj3oBV3WTTzYWVJ7yQ6aWtVgUErYWzyUJ0hqW4Gr8EZr2QWlweO7s3UhddimiQ3fCWERmcN7Xc02jS404s+VORORZLq0g+phLmePh4sxk2K7he1Z7l5odyYS9mqu5sQbSCxINZugjRnRb1vJH7+CYah6Elkk6AGR0LP8sFZMDGZBFYeQnl2nE3+vqHUiZWfqs0psKJ29EK0eXP7tkJewZXTux6UtSJUZglITwdUFKI2D07CZylAf0cyA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d23695-a7c2-49ef-f997-08ddd35f1e71
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 13:59:24.5843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mK+A15tfN+Y0AFSask+jBXATaKuMcy4zDvURB2+hE+1c6CKV9bzuPEijTaJdo+7Zv8v1au0G9iQms5XdMzmPEgAkXaPCkoe3C3aGy9O7BLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508040077
X-Authority-Analysis: v=2.4 cv=TrvmhCXh c=1 sm=1 tr=0 ts=6890bcc1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=hdWO2sGdCZdvxkCvdvcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: p5cmLQI5WBGVDe3v-RrI-KS4CsqMR0wp
X-Proofpoint-ORIG-GUID: p5cmLQI5WBGVDe3v-RrI-KS4CsqMR0wp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3NyBTYWx0ZWRfX14++Edexbo60
 pAZORnLzS0/1WSzn425grsCOiHCAL6iaa6kPbAUWGNNA1lcPRvb5bFnYVrCe1f+BbzGMKvFXZ0K
 ZzoxspdKnpYfb8TT/MXeVLXF+xxYPUCqp5tXIFoiTFqdhsTlu3teffhtWBWrgRZpUd4oK/jumcy
 S36S3RdkZj2rKKn/SB0hM9QC9OP62qc3mZdImRYF0SOlfMkTw+rWeInktlk/V0KC5tYspGCFNXt
 ADVlw4eC1yTyw0AC0xoen/SzdyG5TCQXkjmxwLCcSkQzfeFFZBIHValIyBsk5/DXYLRuhnEssKd
 fdLjMtDc4h/dVeV6uE521iCgZZMRtXJSXoqqRlYsE1XM61Ja0VJp2uLQcvqLc/3dIdlwn08v/V2
 YyZ/IhNIawCUh6dpy8rK4ho5YSMTXw43vMrEpUXy+6rwlYgQ9aJihkyTQmOxEJ6zTNEf46u0
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/28/2025 8:38 AM, Cédric Le Goater wrote:
> Steve,
> 
> On 7/21/25 13:18, Duan, Zhenzhong wrote:
>>
>>> -----Original Message-----
>>> From: Steven Sistare <steven.sistare@oracle.com>
>>> Subject: Re: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
>>>
>>> On 7/16/2025 10:43 PM, Duan, Zhenzhong wrote:
>>>>> -----Original Message-----
>>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>>> Subject: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
>>>>>
>>>>> cpr-transfer may lose a VFIO interrupt because the KVM instance is
>>>>> destroyed and recreated.  If an interrupt arrives in the middle, it is
>>>>> dropped.  To fix, stop pending new interrupts during cpr save, and pick
>>>>> up the pieces.  In more detail:
>>>>>
>>>>> Stop the VCPUs. Call kvm_irqchip_remove_irqfd_notifier_gsi -->
>>> KVM_IRQFD
>>>>> to
>>>>> deassign the irqfd gsi that routes interrupts directly to the VCPU and KVM.
>>>>> After this call, interrupts fall back to the kernel vfio_msihandler, which
>>>>> writes to QEMU's kvm_interrupt eventfd.  CPR already preserves that
>>>>> eventfd.  When the route is re-established in new QEMU, the kernel tests
>>>>> the eventfd and injects an interrupt to KVM if necessary.
>>>>
>>>> With this patch, producer is detached from the kvm consumer, do we still
>>> need to close kvm fd on source QEMU?
>>>
>>> Good observation!  I tested with this patch, without the kvm close patch,
>>> and indeed it works.
>>
>> Thanks for confirming.
>>
>>>
>>> However, I would like to keep the kvm close patch, because it has another
>>> benefit:
>>> it makes cpr-exec mode faster.  In that mode, old QEMU directly exec's new
>>> QEMU,
>>> and it is faster because the kernel exec code does not have to traverse and
>>> examine
>>> kvm page mappings.  That cost is linear with address space size.  I use
>>> cpr-exec
>>> mode at Oracle, and I plan to submit it for consideration in QEMU 10.2.
>>
>> Sure, but I'd like to get clear on the reason.
>> What kvm page do you mean, guest memory pages?
>> When exec, old kvm_fd is closed with close_no_exec implicitly, I don't understand
>> why faster if kvm_fd is closed explicitly.
>>
> I would like to send a vfio PR before -rc1 (tomorrow). Could you please
> respond to Zhenzhong's comments when you are back (today I think) ?

I am back today.  I will respond shortly.

- Steve



