Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082FFCAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 16:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw1P4-0000Y1-8P; Tue, 09 Sep 2025 12:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uw1P1-0000X1-Fx
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:41:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uw1Ou-0005Sv-Jh
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:41:07 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589Ftg86017656;
 Tue, 9 Sep 2025 16:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=6zfcOd7pLCDBxne/8c1PJwsg8RfnItbudSXrBzn21jQ=; b=
 NCD2zvtDmC5ipXd682Ux86LnUAxRn/+AaY3X25jZDtBltxLAY8ONYZKx4cKDy8kr
 KnMdlcWagzBipR9ZW+O6h7R9jrHH9Qjt5HawyfbBbnIJbdzmBHzAL5iRdTuBWWJH
 3ZJlRhdm9qqfrn9E/eqJrYmkUlmhg3mXmES72ONt9bi0gh2Vfg/w5KTgFod39DmX
 UYGNvee1iJD0N2thb0IBtDFc+vqX6GoNAlM4yc1mAF822+zWNmjzJSfo/+XZKpaw
 BjrHQ3Cuu2tBGkqzoAH/ylpLhEhWHV8eyCnW0FaplGSgxCXdtSggrRGJkeft2HDu
 C7ATWKjsH37xhN0i6smFhg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2tem8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Sep 2025 16:40:55 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 589FhjVl002962; Tue, 9 Sep 2025 16:40:55 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 490bdgctva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Sep 2025 16:40:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0Xqh8IDeZKklWJdj3MwtG4dQFH88oPCE9xH3HanDtJuXFAHqLeXOpym+BssBmbmbcxAky0joaYU9dsdfAWw2F+moxoDHiL7rFO/DAegnB7iIttEQIeEZGIxXeckVsiyqf5xADHz5ExMJMrrcJxO1pcaDQFnf/plWr4ynWwcczxCPV3Nsv+1d5JeOwabCVl7nDBv1vJtF1zwWNiVF+IKiw0ij+RjBUxhwAQEmeRjg59qMSAoEg2ZpAfxDDFu1ivgw+bSxm6jQuDIOCfzyNYyK53/ScK29ubFn2JF14wL9qLHMwrLgde8LCl4m6f7PxhEhM8vXyvbCP2brVmKOY7xVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zfcOd7pLCDBxne/8c1PJwsg8RfnItbudSXrBzn21jQ=;
 b=ydRHjSjMF3biYf+5BcTxdEU7DKQkgRi0bpLTgmpruiZZ5kDAtqPH72B0doAxdwYO/g9hElbAFB4dku1pAbZpJIdgOeqfhUybn8/jh/3WnAt2Xhncb+M0XAqI4fvWN738DEGvypN7QncTfdEgtgGRddixamEP2/rS0nvAearCAGzz1wWILOEhDe3cJY+4mQ3p0EmXOCoELNRPiZDJXYOCLhNZiutENVy+XXkzdUkg/g/g/PFPXTMs26BlRVhjEiRfq2jmvLR2pBEZutk6dLGoZfvz2zQb58NYbCCC45F0EqJpOay+y1eaQfGamvlgzBK4omBOxg5880Ev4RYGQwPI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zfcOd7pLCDBxne/8c1PJwsg8RfnItbudSXrBzn21jQ=;
 b=bmzd3Uws9uZYiwhirRFaDvJVThfa0tBrSWhdVH83x8ZX7Tjsc9//fsvvlp15DbtTiknB/qUiwudaMELwH7tCAYUEyD1sY8Gjc5CQgJFH5R38NQX7sSjhIbTsFdkTrCENbVHTqBpLWTWxR51Wvajs/Zr1yeLDedT7OL9n0Pp2tss=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BL3PR10MB6090.namprd10.prod.outlook.com (2603:10b6:208:3b6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 16:40:51 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 16:40:51 +0000
Message-ID: <d0cc49d3-7909-4432-9727-35524a6cb4b0@oracle.com>
Date: Tue, 9 Sep 2025 12:40:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/9] migration: multi-mode notifier
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-2-git-send-email-steven.sistare@oracle.com>
 <aMBLIJU6i7yzObjP@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aMBLIJU6i7yzObjP@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::37) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BL3PR10MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d6347e-8bfe-4d2c-72a2-08ddefbfa2fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0tpMHhjU0xvVjZVTmhDT1hXQW9CcWFudkVWbk52LytqTkJkdWFNMFlVaWF0?=
 =?utf-8?B?RFd4WUVJSG56U3djRlZwa3c1SXdnMU53eHRpZGd0VEs2RlZsTktoUnB4MlVG?=
 =?utf-8?B?Z0N2czcwYVhqSzRxcG9RMlN3a1RxR3ZYN3h1L3BvRWxsbnpzVmVkMU4vOUNQ?=
 =?utf-8?B?MnJjNHhBZkdCUTJXZUh2cm9ObXBCYTVTVEJrTW0vSTV2L1VCd1dFTWtJYkVM?=
 =?utf-8?B?TmhlZEg4YVh1UTBMSllIbUVhcm1PUDNJRVVheVpuZXppeVVlT01YRmZWR2JU?=
 =?utf-8?B?d3lhNUt1UTAwKzRpMUZpVklYNVZnMVRQZGJROFBTWnZwTFptaU9WejlGS1Zr?=
 =?utf-8?B?VEM0QklpQkJ4d242akRhMVE5eWMyK0dCWDFqZzFuZVBha1Ewa3RKMkFpUWV3?=
 =?utf-8?B?TllNb2lOOWk2NkNtVlEyazRSV1lvM3NJNHJJS3JhcEZFLzdlU0lianZFdVZC?=
 =?utf-8?B?UHVKVFVIWU1CK2tVdFdkMksycC9mN2x5ViswQm5BYjhLb2gxSVNNUE1GWW5W?=
 =?utf-8?B?WUliY1FrdnA4LzdGREduZGN6YkJkYmRBOWlLSFhIRzdyTG9mTVVMZUVvRytQ?=
 =?utf-8?B?NTVoL1hxVDJFRllMRzQ1ZTJHeWlKSUF3RWlrNzZsd2s0eHVOWFFVT3AyU09x?=
 =?utf-8?B?M3k3eUVRb1BwV1VqQ2JzZi9JY05kcGRzcFhScXRGTEUzWW1ra2ZDZDNnUmZX?=
 =?utf-8?B?VDZtT0JMdVB3d1ZBMEVJVGVJTU90Y2oxblAvWEQwQWtZVG9rUStVUzdVbkVB?=
 =?utf-8?B?dHlhaGhyR0NzNnFCV3JEdHl6ckI5eHdpb2RXWUs5YVN2SlVyUEtuZlQ4TCsx?=
 =?utf-8?B?a3RxTWorYTY4U3Z0NXUzYml5N2FWV1IvNm1DaVk0cmdTaVkvaGJCVW92Y1Rw?=
 =?utf-8?B?Vyt5R1h6Qk95Y2N4MHNBUDdCenVHbENnQ0pVWlFUQy9SdjF3MkEwM01TbVZS?=
 =?utf-8?B?QlBRVXc2eGprdnRodVl6T0JsK1ZQMzJ1UUd4dlEwc3FUTUVEa2ZaQWhiWm0y?=
 =?utf-8?B?aWNLZFdRb09HOTNZcHpBRi9Sd1lxVkZZbWwyTWdTbUg4dEg1ZE12WkxVUjJ2?=
 =?utf-8?B?ZTJMYVlGUU5hOWRPaForT1l5RzN2UTFiOFZkYThkSzR6WlVJMGNaSUVVWFZZ?=
 =?utf-8?B?Y3Q0SWd6MkUxd0ZTUmlmOXZTYlpPQnYzcW8zWWZld3BCa0VwNHV2bkZUM2ow?=
 =?utf-8?B?SVk4bmlNMlc1NERiRHFxaXYveEVFVlpYeGRBdUFjTVhhT3pqZDBnbEZZeTFW?=
 =?utf-8?B?VWZ5THpTMFRkeVdkOU1NZk0zZDNLTG5XS2tWdzNmdDNndm9mdjdGeVk0Rm83?=
 =?utf-8?B?Z2ZySE5yRDhjclpVMTJxVmU4akppRmwxdnViZHFiVEJGZ0hvUzUzcmlpNlhZ?=
 =?utf-8?B?eGFFbEFZRThqQzUraGY3N2IyMHc5eElScktqc3BPbkFmVWtxOXkwRFYwa3Fo?=
 =?utf-8?B?Mk5Ea0pia0NvUUgweDkvTzlzNFN6TUZXUFAvdmI4Z2JYekp2dlFMeGlyMCtM?=
 =?utf-8?B?SzFlRkV2T21abUsxZFhlaUg0bXFMSkxQcUlrNWdlY3lLYjlBb1RPSVJEV3lW?=
 =?utf-8?B?Z1NIdFd2UHlBYjhoMEtwUVlpZ0NLUUw3cUFLbWV6aDR1VW8xeHY2bjZETjk4?=
 =?utf-8?B?Y3pXRkdYUmZ1aVNPRTVrZmpLS0FVZlZUeFpvakcwSGRtMk9wYnpjSlBXS2pj?=
 =?utf-8?B?ODloa1N1bDhYVWorYWRFVlU1eW1tYU1uT2FrbnlyNmU4QWhaN0xDbi93WDdQ?=
 =?utf-8?B?aGxTeVhUTll2bUN4NEtzYSs1RnpUQ0djYmlkQklibjlWbklUWGlTc21lL205?=
 =?utf-8?B?WUNMYXdhWUVkTlMyWUZWZ3d0VFdnZTQ5Ylc5RThKaHMzaVJiWDBYbGs2V0Nq?=
 =?utf-8?B?cTBEY3hUMHpYSFZweCtNREZnRitVRDc3VGxSL3I1UStFSXN6QnIvNVJSak5F?=
 =?utf-8?Q?SgQFI25Bmo0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGluaUJhZERhZzJEVmxSaHUxTmZOSlpqV2ozWEpkUitaSWRkS1BQQVdoSzNM?=
 =?utf-8?B?cGZERS9IZG9jT1pHMFVZT1hIZkpuSW5vNU1yTHBQQURYTjZVaktSNTBXbzlq?=
 =?utf-8?B?NDA4b2hTNTZyZkZMM2ZBM2crdExBT3pPYVFMdEdQV0EvZ0JSWHVFTHVZQ28v?=
 =?utf-8?B?R3Z2SW9aZis2MjM1WTQvQUwwRkt3Nk00Tys3bDdGOWQrUTJiUjdkSVVvWlBZ?=
 =?utf-8?B?YzRDV1AyTlVqa01ZUUlPNlpqYTRtWDRBM0psYnN0M3lROUhqK1hjTDFPLzhi?=
 =?utf-8?B?Y0d1NnpQNU03ZEJCOVRRWm55VE5kazFYSHZDSUQzMWJpZlZDRXVYTW5GS3dp?=
 =?utf-8?B?SHJqcUl3ZHFHRTNROUVPNnpvcTltMEtnL3ZIMFRjeFF2RmhUamVjbGIvWVov?=
 =?utf-8?B?MGVQM0tFSzhKSGRiNWNwK0M1aVNwWHdPaXQ1Uk9YZGt1bTBXaWZXSVFqaERT?=
 =?utf-8?B?ZWcxK1RwVGhQMzVKQzl6UzlzRFd3SFdmeWprUHpMRE1EVktYeGxSRHV5K3ZY?=
 =?utf-8?B?d0ErNFRadmpRdDhtek5Udzg0cHpicTk5Tm5tWW5La0ZzQm1uMURxcjd2bzc4?=
 =?utf-8?B?ejErVmJZOGhEK0FDVjc0SEQ1ZzU4bmdnNFZDT3psUEd0Y3pkT3p1Nk8wMFQz?=
 =?utf-8?B?VkxrMzJqUjFyOUE1TE1HZXJrcGs4dTA1US96bUZxMWNCaTVRa0cwR0JtWndS?=
 =?utf-8?B?cGdBQUdhQVV5QkxoZjYyYVNpNW5xU1JOYXl1NG5oS3pUVEpkeVM0WWVXUVF5?=
 =?utf-8?B?YVpGbFZ0UGxJOExpRnBjNTJmaXlsUWRQQks1RVFmWllyRUdydEhINXA4Z1lh?=
 =?utf-8?B?RDBRVm9ndUZ2eVFqV0tRQ2tVM3lQd0ZZNjZybkhGOXNHeWdSR0hDYWNKK2xq?=
 =?utf-8?B?d1JyZHEzbzBtTGkxcFZJZDU5Nm5ZbnRlcTZsRDRlMVpUdGhkVU9Hd1V1M25t?=
 =?utf-8?B?bmp4QS9LN3NNd1JRd3NuUFNDZUY4Ri9EM2JvM0VLbVNpd2Y0aWhHNkZNRTI1?=
 =?utf-8?B?N1BaRmh5bG50S0ZpZldHbVBGcnRkdHdrMGJBazBZRTZZTjl5Y3FLMWUzbnFj?=
 =?utf-8?B?aEErOElWaHc0bUI4bW1tY3BNd3c4MVVxUjViZ01mYTYxb3ZlV1Q3QVhQRG1X?=
 =?utf-8?B?VC9QWVhBY2QxSFpKYm9odEU3cnQ2ODlEYlB6U2I2NDduQnhHditmRUN5aXl6?=
 =?utf-8?B?c2dLbVhSRlRteWdGcmZwbkF1U2hrajd4NlpwWG5mZ0tBb1U3ZHhhYk43WXBi?=
 =?utf-8?B?b1hnZUtONCs2L25tU1pCRk1sb0c1NWNrb3JlQ0dYaDlGY0dhanZXN0VPOFBo?=
 =?utf-8?B?cXRSd0dzYjRuek4vN25iRmQ4Zk9vN2IrNGNuZWpXbTZ1UGJ4OWtzOHZJeVBv?=
 =?utf-8?B?aUd1Nmk2RjlCKzJ3NlQycS9MWEgvUzljejFBRVBLajVTdmZSUWtjRVZtVldB?=
 =?utf-8?B?OHREczFSMXNwd0pmWndvQlUxWVhXd0Zjbm5aR0tVM2JvSHFLdFhISzVCZkty?=
 =?utf-8?B?RVV3bmFCYXFlSGVRNEdJYnNIWS9EZGJjdnpRMlhiOTR3UnI4Ny9Vb090eTRN?=
 =?utf-8?B?aVlIYnB0L29DSTZ6eE9WZXJvNGdIQmtXWkhKZDE2Q3hoRk5nMUE1Nkx6eXU2?=
 =?utf-8?B?NDJkYVFWVW4zNHF0bUZRa3FleGd4aWVCdG9lMXA5dXpnOEZ0Q3l3dkx2Lzhi?=
 =?utf-8?B?MEVjazduWG44UmtmTEdmcjg1Wnp1QUUwNVBtVUZrT1IzM01PRVZBdGNaOFF6?=
 =?utf-8?B?d0VzbXVRVzE4a0c2RWxoQkRnUmVUVUIwK3o5M2FvRGFITzQvYzlIalo1b21p?=
 =?utf-8?B?bmZuYzdRN1dZY3l2VW5tb1ZSYUJzOXM2M3NWQUt0ekVGWTBDMHhmU1g0QmVl?=
 =?utf-8?B?cjBXMFRSK3lDU2N1UVRXM2VJRDU5dHhiam1BUHE1bWNVcnRIelhldzJXRmdR?=
 =?utf-8?B?Y3pOSmF1dTlIZXBmdzN6ekNEaFF6ekhLKy8xdFZIMmsxNk1rYytyNEZ4MURt?=
 =?utf-8?B?anhrVEFuTVF2VVBYL2h4dk52MWx6TkMyRkZQTW01WHk4NlhDQjVSUjdwL09s?=
 =?utf-8?B?Z05CWEk0SkpZaXg0eitUUHgzZEg1THB4TERyNXZuRmRBWWxsSlBGVVVna0xI?=
 =?utf-8?B?N2VZbm8weTJCdUFOY0hKSys5SmREUzR5TFNyNU4wWENyVGFFVHdNaTR5RDR2?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X2hYLPd2dPSpOzS6mkjqq+INw2NQ1PtYGemDp/rxMQHrG6cNyOQNrTe2pZE1x7/cqF/ALDk+KTE5C3uvnlW18Ja6zSIYNxS3AfDS2xItfsaduOlCmR9rPW/XyWwBvARXJFDDTBI/PieeUqxvIZcLQBmwL4kYCaIwT6unjMk/qFHPEXKXhpkqgl/L7nRDxmR5OalYu/u6xND2xuNDpRlsBF6iX8SnDPxkfhfnAG1r5bFG37fzalR+g8X3E/SDqNtC7SXFSqbHBKSB1F6u/7l1cSTAVdUvAGlBUv5wpBAHBj+N4YaMnBfguq7Tt1k8QsncjvGxgQJIaTWiErNMIxzZhhIOK+/V7X6FLtKFISDZGvg+tpB7Up09KGvNgTqa8i4pUs5dF7vUA+LJkZLkS88X9/fGDlLCxbyA5pcMBfkrobFwSWtifIy0HuWTfTIYtgkSJMlfaP3yhh/PscJEgx6IlHQrot3NN8MeJQcqUTX7dGNYDzsEAQi/d4mq13kJw/oC6Bc9/9+FCE92YVkFcsh3KEZG/L3c/muJz2Ongugl7sZ2Vg2Hmiz7xpcnVh+w3TVlCRuFXKc0+sCYsUjuK1lcO4vgTYtFiU3P9CHJO6AlguU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d6347e-8bfe-4d2c-72a2-08ddefbfa2fb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 16:40:51.0174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6Q53cU4+SBpQ0TXCWyTjJhASZOwR8TAkUVKnLNloZ+AKBUhhkuiO6S2i2IPAb3xb/l+7qq5WXJtZOvVRWKvAl46ouyhaP3bjxo0k1ED0XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6090
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090164
X-Proofpoint-GUID: LB_fXNelREQ22j4dwrgIWnVL-2E20LTb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX2nX4yy6ZUbL3
 1oeCNPYrVqCUkK07iOkXkSVpOs45lZj/BHmEC412NfVveP/pt4GsndWMfQw0eTXMcXeAmuKGIze
 Fxm2HpqiwlFVZocSH+WNrGV5azhqJucmzZOPlXSSZrM77K+ba3pzFI1cJWaIn+D+SRc2hkDjQ1X
 jOMi2YijajaiNEjbD6kHRstoEgAWm4lta+piFj2x/2nUeQt3ZcOPmXBMj5rhOwC+KNwK7u2Xnl/
 K0tfVh45hTGt18nicD4iwMo1mx5c3AGbpkN+EmbbbHfp/4le7t0KwOlF4JeFR0tFSkMTDTlsZm9
 lSI43mOhc4vGW31Cs+kjhmiUJep1ZbeKFX/0odD69sT6JUhbDJVXsZRUIeq/bOY4dWIokBq6l60
 ASqt7pcPTYa7ebyyq9pgP9uDgJSmsQ==
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c05897 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=1sleSyuGOoVhiY1uSj0A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12084
X-Proofpoint-ORIG-GUID: LB_fXNelREQ22j4dwrgIWnVL-2E20LTb
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

On 9/9/2025 11:43 AM, Peter Xu wrote:
> On Thu, Aug 14, 2025 at 10:17:15AM -0700, Steve Sistare wrote:
>> Allow a notifier to be added for multiple migration modes.
>> To allow a notifier to appear on multiple per-node lists, use
>> a generic list type.  We can no longer use NotifierWithReturnList,
>> because it shoe horns the notifier onto a single list.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/migration/misc.h | 12 ++++++++++
>>   migration/migration.c    | 60 +++++++++++++++++++++++++++++++++++++-----------
>>   2 files changed, 59 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index a261f99..592b930 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -95,7 +95,19 @@ void migration_add_notifier(NotifierWithReturn *notify,
>>   void migration_add_notifier_mode(NotifierWithReturn *notify,
>>                                    MigrationNotifyFunc func, MigMode mode);
>>   
>> +/*
>> + * Same as migration_add_notifier, but applies to all @mode in the argument
>> + * list.  The list is terminated by -1 or MIG_MODE_ALL.  For the latter,
>> + * the notifier is added for all modes.
>> + */
>> +void migration_add_notifier_modes(NotifierWithReturn *notify,
>> +                                  MigrationNotifyFunc func, MigMode mode, ...);
> 
> Would it be more common to pass in a bitmask instead (rather than n
> parameters, plus a ending -1)?

Yes, but I defined it this way to avoid the common error of passing a bit position
rather than a mask, eg:

   A = 10
   B = 7
   migration_add_notifier_modes(A | B)               WRONG
   migration_add_notifier_modes(BIT(A) | BIT(B))     CORRECT

and because IMO passing A, B is slightly more readable than passing BIT(A) | BIT(B).

Note the blocker functions also take modes using varargs, so using a bitmask for
the notifiers would give us two different representations.

- Steve



