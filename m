Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9BDC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2nS-0006pt-2E; Mon, 19 May 2025 11:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2nO-0006jv-RT
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:52:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2nL-0000WW-V4
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:52:54 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JEP9S1014776;
 Mon, 19 May 2025 15:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=+6NR43+wL6sfSg5HLbPdsTVnKasnIL6597AsnqncNTU=; b=
 RfWgOG7YRKqS0IDHROK3j7gu/mnLB+/SxduxSjSzeZdOtQ84MiGqkGJA8+wL5BEw
 fKn49zWMce5+WZpj6sdv8m+kB8qPtf3+f9K0K6haSc4tZI/fM136iGdOAaD5/uWY
 jcKrxUs/o3t1IQNtw5Z/5zUROSZ5eNu7abY77P57+l6BMuIYX48GhpQ35Hih+K4R
 BH6LWspNJQ9QHczE8NCHPLGUMsp5RugGmwdSl2sT5jnnzEYGdcB2/LzxYqgQs3kQ
 ku5v0ZFsrSrJLJ2KV7PJnbS9FgxO0koNiZs5a0HAC+6luO5VWNMtZk5gIQ91WMEx
 XQQ8RcFK4En3AQC80aiTBA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjge3d48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:52:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54JF3xnH001077; Mon, 19 May 2025 15:52:44 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw6vvvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:52:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGNdtjXELLv9uAucWqozkH/G8hqn7VvNfZGwKODmakcEzQWEmS8VZ/w+oPlCB0aXXisJHlvBMkLx7OrRj8tEoMraJNEwTHzTNywZmL/qVu1CbS6g0hqVfEftRJo8vsJR7NQZiyRaRs1cVzMh3u5OqyBHyvcBNNAQ00Fg5/bFiQN55LrJqYOxi78eQhEo5yEA+O73vY5XJ/r3W01BQv3N3qV0eSlJ44dXvkUfrwP8kTGL1aXsokmZKGJTFCDyN53m7j2Z47hn0+wRTkw/Q3DjqTDaXnkZ8OTetsvv5BzVGz/beU51N9ijSoDgJnwk21FP/QMYH2lDSRwoWRKGhTq7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6NR43+wL6sfSg5HLbPdsTVnKasnIL6597AsnqncNTU=;
 b=TI8H5v+nWVZL/UhPlu8nr/u3mj8x+UI2ls8eiAgWzHHXRr++PpjMPoY7a9jIoETa6XxVGgKto1viwIsGT6b4t8E0z6hMuUzP0vaIHYFZ13mZHawT356gThqKlegE/KNx0/3PJky/bd37iVQCzfJDmWL+UojvGBphjbAV8oxd7r5mtmkZEcBGP60LRikAc0+to07EJztaRyEaqy8F0vYkgmV5p19+SEtWmHo9YcVbCh2UyK4/Jz3YD9yZ+dQ8p3Omt2Cl8wjzYXzYS3jeqOEQj7yVgvE+zClDvpITHfgbyR4T6yZscf/RiBtEEXXdp8n1tKQ8P1q/+AK/LPk6ZZKC7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6NR43+wL6sfSg5HLbPdsTVnKasnIL6597AsnqncNTU=;
 b=hP7t2VxsqnVhtipljcuxWMP2g+W1GAzBi1+x/VnIiuRENHgW5PIQbLFFqedhtxt0POZs3BicUzq1lcrqA6DS9eskjDCSvqThBPPrcelFcrra9vF8L8hE2sgDPpvta2YdbGvnO1R/lpIBZE++uyLbr1DeHVG0Iwf6r93FL0FIFTI=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by DS7PR10MB4848.namprd10.prod.outlook.com (2603:10b6:5:3a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 15:52:42 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 15:52:42 +0000
Message-ID: <65b4f27a-fb99-4398-9d4c-16bd8add1936@oracle.com>
Date: Mon, 19 May 2025 11:52:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 35/42] vfio/iommufd: register container for cpr
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-36-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB674407DD9FFDF027C9F820BB9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <SJ0PR11MB674407DD9FFDF027C9F820BB9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0383.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::28) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|DS7PR10MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d3f216-4ef9-4751-5fe7-08dd96ed30bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alBNVndvcG9yRFM5SzFEUWFFRUt2U00vRy9lUklHbkhGZVQxREp4amZOR3Jx?=
 =?utf-8?B?Q0RKUkc5ck9uSlNuOTlydFk4TlI0eXIzVzBUSHNONm9rUmh1L0RuL0dRYjMy?=
 =?utf-8?B?eDNLRHJydHMxZFQ2YTVzbjJFdlFTTC9wbVZpa2dzemdWVHpLZFE3NEtyWTJr?=
 =?utf-8?B?S2p5aUVvZURDQWhwK29MOVZETWlCcGU3MEhCMjU2L3B0NU44MXhZUGNvcUhR?=
 =?utf-8?B?QjRkcnFXT3Iyc0lGRVQ2UlQ4MVFnWDRBWkdlaGlmNnN5cGJQVk9UOVk5bDJq?=
 =?utf-8?B?Y2c0U0w4K1U4am8wTFQrc1pXQW5SRjhPV0phZm54dDA1dmVmRERhSzJTUlZS?=
 =?utf-8?B?MjNJaHFjYlBwRTU2ek5pYytKQUZvQmYwdHVuaVRCZDczZkUzNHUvODFpRXEy?=
 =?utf-8?B?R0xLWng0cTV2WmdraDhqM1V6NkluRlNibGYzUDJJR1dCVGZEdmw3eExkaWx2?=
 =?utf-8?B?b0xjQlRmNGFkODc1TDRmV29qUnZWTzVOKzBqV1gyblZXTXhBZkJ4cXlsWVZy?=
 =?utf-8?B?Y1lsN2h1SUFpVFh1STJmWnJEQUhqMjVuSC9ZdDkyYzlDaHVUNnp6dVdtSXR6?=
 =?utf-8?B?SmsvNFIwcVY0V3Z6V0tEWEFFVlVyOExhWXd3ZVVTakJ1VmJHMlh3ZkQ0RytD?=
 =?utf-8?B?UmM4SEhpcWs3RlVDR01qSkNGb2IvdFFDSkxSZ2Z5WmJMRUFjWlVCRXI1Mmh2?=
 =?utf-8?B?S3o5bmxuUXBVSU1PQmswNktpRHhxR1BRZU1ScElibE8xdjZlZ2tVeERTeEdM?=
 =?utf-8?B?YnAveDhzVmVKRjFCNnhVWStTdGJDTFcyK24vbUZDZ0MvN3plazhqa0d4UGRW?=
 =?utf-8?B?NlhmQWZFT1V0NTFBUERPUGI4Z0wyRGIxWG9ITCsrc2Nzd0xNZjhmaVAyNVJV?=
 =?utf-8?B?OENZdnBCS1dJMzZJTmZ2YlhZMFlIS2VoaTJkVW5WUUZRS1JHUzd3VFhHUm11?=
 =?utf-8?B?Q1NYMERaa0YxbGVCbWlaWjZsSjBYVWVBdnVWK24vTitQVEhNWER4Y256WnZR?=
 =?utf-8?B?UFh6TVZOaU5PWTM1UEFRcmJKU0dzSDRleDk3ODJXMVhvb2tObHAxaXpaV3g3?=
 =?utf-8?B?cy9iZktyZlFuTGNSTUZSNHBlVXlzOEx6L1U2cStPNGxTWXZlOFF0UHhXN3h0?=
 =?utf-8?B?UDVueEpuak1tVG1zaFJkZFhZSzVFMXhFV2NkQWcyS2hFWEN6QzlqeVZha0Zk?=
 =?utf-8?B?TG5RRzdvaFNKOWVzdDBpdlpjOU8zSHpJbEVCUW93SXJYWC8zVWtpSDZSN1Ev?=
 =?utf-8?B?UVQycXNXM25XUERhampvTVF6S0hOVW9Ha0JtcFNYbmVFQWlMVUhXV3RtT3VF?=
 =?utf-8?B?ZnNRSytCeTBpK09aUmZCeDVTTHZGYWthNzB0L2JzZE1BT0FpVFJ5QzZVa251?=
 =?utf-8?B?aU4veXFKY0VUSEVZdDlybFhOalQ1UWRzam9KZllsdHNlMUZnVEMyTWZ3bFYv?=
 =?utf-8?B?aURnVDl5Snl5K0kveTM5cjRXS3kzVDA0TUtQZHRmYSt5UVFBUDRYcS9KbEtz?=
 =?utf-8?B?bEUrS3liT1FCTjNwOTM1OGJKRE1KNEFrK1lnY1pURkhVdC96Z29qRHhpK09s?=
 =?utf-8?B?SnZKNkxWSFQ2UTR1dTJRS2M5Y3pTWFFUWmpLSE8zdC9QVGxQUExVVk1tY2tS?=
 =?utf-8?B?YVdVVEQzOFFCTjJoTHlLdndKc1dZOVFsVTM1S0k5YkJON2VQd0xZLzIybTlk?=
 =?utf-8?B?ZmZJUUdVL0hIcFFxdUVXSndSTTZJNlVpREw2RThVOGFBRDVMRmRiOXNYaWJp?=
 =?utf-8?B?SWJrUnNMU3p4bTRrUEg4OFArRUJreTBJRGc0UDdvTERWRERRMFV5Tm5WWUdU?=
 =?utf-8?B?Q0I2OE0xUzB5YXVTYzBGWGFCYnVhM2cwclRSbmY3YW5wK3pCOVJtQUVjd0Qv?=
 =?utf-8?B?V1dPYzlZWFpBWHNJb3ZRZjRycXRib2dTZ002UlVtdGx2VXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGR2OWptdFJKalFvZjdpWEFFTm5XaXZ1VEs2Z3p6eWtLNlQ0bC92SUYzUWxq?=
 =?utf-8?B?citMSlFqWm5xV1VVZGRIU29vdmdxUGVFNGtWQnBXZTJzZ09vYmVQUzlsQkw1?=
 =?utf-8?B?cEpmZUF0UEFxYXM5NXVvTG5UTGxod2F5TlFFVDRNZXo2Sm45NUVKY0dKN0tR?=
 =?utf-8?B?aXVPOW4rSjBMOUFjeEFMWDNsT0NzajVmZ1N6RkhhQkhLZldwZUtEVFVOZFdM?=
 =?utf-8?B?N25FdHNYdlExNVlXVlpzbHVXKytEMHVjYjY4NXAwc0RIdkVZOVhCaWtQekZI?=
 =?utf-8?B?TFk0MEcrTE96ckpzbHJQaUF6WUMwOXVIRlhrUHcyOTYzOUpIdnIyaFg4dDV0?=
 =?utf-8?B?dmhtY3hXcEpYY293QU52WjVybjlWaFN4ZzJmTHdsaWdiNzVPWlhTYlR6czkx?=
 =?utf-8?B?K3d0YTE5STVFWUN6akZxbUx0ekZCQUpRbDVSQzdHUzVLV3dTcHcra2ZWZlUx?=
 =?utf-8?B?ZktpSWcrc0tHYmxpVHJpdFBVQXhJTGJ0Y3NIdjBSbEFiQTlaWmdaZDFDSFh6?=
 =?utf-8?B?Ry9KMTVpemlCeExjaStpVlMzRG91azhhRlVNb3IvajhoSlp3T2UvYW8wZWNU?=
 =?utf-8?B?YmQ3NnF0eHZaMTI3S2ttekZ6cVlHQ0ZWZTJqTnJzNjN1dGhHMDg5UGFIK3Rv?=
 =?utf-8?B?MVJjQkdKWFRIS0p4WDFHS2ZuYTc4TmpySWdicXg2eFhSYlhzYlRqekZORUR3?=
 =?utf-8?B?ZWNPWUVDYXVQNVlBV1VaNzZzeTEzUlFMc0luVTV3ZkYwblg3bGg0STV4Ujdt?=
 =?utf-8?B?aVd3cVNJWmhTMnJIa0dVOEJwRGEzeC9yU2NVQ2Q1ajJ2eWRxWVNZbHRrdkk1?=
 =?utf-8?B?MXhmbG1NVEN1N3g4SnNaU2tDZE1Cd1FGOU94VEdxcFBsOC9ZeGFvdXl1QVVQ?=
 =?utf-8?B?NWc5bVJHS3dVbEVXRVMzTmhaQnBGYTZXbVRyNmlTaGcwZEtwL0lwNGtUZVFN?=
 =?utf-8?B?QjBzL0hYZ1ZVNk9HcCtyR0tvQXJuT05qVHJOV1dwb2JJOU5rNmh6d1hsNlNa?=
 =?utf-8?B?SDVCS3VlZ051SmcrK2VEUnFqZXZZa3RIY0ttR0lqUzdUMUxzeUNjaVZZSzBt?=
 =?utf-8?B?QVBCL2NTd3AxcXN4RTV5UXBYOUg5TzJpYjZDaVlaMktoV1RtVGM3TUNFYzhW?=
 =?utf-8?B?eXJBTWt0Y3hDaGJCRlFVQUNWSXY5ZklPRkc1SGlWRHMwVFZOYmVqaS95OW9a?=
 =?utf-8?B?bzNnOVN5TVh6TDZQWmtRY0dwZ29zQmQ2aXg0V0JGT0JLcU85R21GeEUwVW5V?=
 =?utf-8?B?OXA4MUZUZEs0TjhiNjh4MXhWbkpMR2JuUXEwbmpDcTQxVnIwMklFY2F5VlUy?=
 =?utf-8?B?NWVKcUZxN3FxUjNVQldkSnFKc0E0ajViUm9OOGJOR3Y3aWJWb1ZDamtRRmND?=
 =?utf-8?B?cG5jMU4zcWdDNFVzZkFvTlc2S3pJTGFLcVNocVNwSTlNditscTZQRi9YZjFj?=
 =?utf-8?B?THJTcWNMUkh4UDVTT2VNdVJtVEhBUFJGbXVqM2VxUTdIYk80RkQzaWlrZC9G?=
 =?utf-8?B?ZGlYTGRFaTNUbUNrZ24yNmJxb1lYN2lZRzlaWHRpQkpZeGpRTWVmZnBjUndE?=
 =?utf-8?B?dGtWNHpkYUZRL0FBbGhHamh2bVl5NVZWUytieWhWK0NLMXorVEpiYmY5VVVj?=
 =?utf-8?B?YktYekEwT1B5bWUzY3NoYmhYR2VOS3E0TzJpVW5pNFBxcXQ1R1YyOG4xT1pV?=
 =?utf-8?B?NjlpbDV2SXQ5RWxObUtJcWFGVXdscHBtRUhZd2R1enNDZEpUeGFES1o4LzRj?=
 =?utf-8?B?UDJGdmdiNk82MGxqWmpEeDNzL3FCVnZKSEVIc2RMRUtYMktEMC9aZ0JBaFVP?=
 =?utf-8?B?RWdJNXdNTXNiUllmUDVENXZxQXBBK1hVaW1LL3Ria2hLM0VQblJHRWpMRzgx?=
 =?utf-8?B?K1VXWHNxTW1sR2pKSWV6WHVlSlR3anJ0Z3BwSmNncXoxWVYydmx0T0RMRWM0?=
 =?utf-8?B?WkV5SlNPRDhRTlNxVlMyZ2Q2eTd5UWJVMzMzdExxdFNWcnkrd0lxcU00b1Fq?=
 =?utf-8?B?OGkwVjYvc3pLL0pwTnpCVTQvZnJFenRtUTdObzkzbWFHaDVOWngweEo5emRn?=
 =?utf-8?B?SEVjRXJoNU5OZGJqSExXM3FPZitPUXJ1dWw5eTNjNUhMYk9Sa2NQYXFkRmNs?=
 =?utf-8?B?dVZKdTMrRm43azhTOWdpSDc4aWo3SlA5TTZVTVA1N0hVMmRLcjU1S3RBdUlR?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XJgr84wgWb7YxeqkAeU+6zWGKYPbAqbFh/syby8oDN+m85PptPd6D3db0ZkWi8yoD5CAlLC/z0yxFD5w0Ns7eCmhv37UHq6RKCtiLsSaHZUWoUZMd00IttRtygJALc3d8Zww/JWwHxn4sGDf53ocajHdi5q4BZp3jrKEmzWvuf9QEs53+S/G2aS/+px319355i3fhKj54RRDLirRrX0PcxmhHQS991CyiCcsRxRrxOLhVtCnomrMe3q/aPDcJund1FDza4/F9nvIbTyyE+mb5oKp4wo0vfufP0YBVYNB7o476+vdq7U43Olmue0X6xt89AeKCleRfMOdKUXGYM1WyH0GHo/iX3puKB5w8DTWbFITzJo9e7xCxNq3DmkG50e+v7F4b9cBxFSjvwFTFkIC11NxZZVNBI9i09K1qELKgnWhCBP4GQjMvMn50nHJtE64PWZ0tJKoburogbQvjvI7kCQstbhpwEc6iyyIGq23Qc7EONowSYoFKoJkgvgJj+5+Qua+BLIMJ/Wjs4eC5PFXAoqD+DxsefB57H1OwQIfVDW7c7GMY4jN2Borei2KxrmkIdG8JvVdh3MwXXGAZf2+Qf6zpxQbZ7YpS42EQdsqI44=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d3f216-4ef9-4751-5fe7-08dd96ed30bd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 15:52:42.7034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlfRTIAI494uGfbiZ4RZ2UiaOMl/zPKFSO/sqYsBMXxo9zOR5TVofeWZ63ScsxwUta3jzrOF79XHymYjqC3m6umADRXQffj8rsv+D4Rx2lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190147
X-Authority-Analysis: v=2.4 cv=RamQC0tv c=1 sm=1 tr=0 ts=682b53cd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=1VF8SDoAWI91RAT2NfAA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:14694
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE0OCBTYWx0ZWRfX5P74RTcEOYLI
 m9i3EVYSDVmM8rOAy3Y+ocDMVcAMooi63vbFabsiwj+V+t3xTpNHOaG3hyVN3g8D05YCCA9dfPE
 DcEaSlr//ib+nHAFPdn9WHRFhswTCrJ4rIuII9YKACP4ScS1uyQbdzkgoyPQVyKdArAPkS015XQ
 vXhyJf0n/jMfktQcYe6DfFOajrddIYtSwucJPt2MNy9zXO67JTq4RSt0GEFL9K4ZnusloJ468DH
 qslJBNrwCP7Uo0C5URD1dkMb6ilvb3UPTea9O5BQpgzbfaDEbvzh5LDB0LW6z1qMWNcuma+wdSO
 Z8QDdIRH/Q4MFlDmZzURs8ccEuhielJyDe4HYDFa2wEEZ4RnGdOwnczd+3Y8tP85vo+RmVtIm8h
 S7xcvNOXRySx5456kiXzJsMEGcn3q8ROGoMg4mrR3bcY+TYM2fqQQKPV4EOqLOOO8mVQ7922
X-Proofpoint-ORIG-GUID: XYt5QbhGaScNHyIJ0FrLuup3-qUApdvB
X-Proofpoint-GUID: XYt5QbhGaScNHyIJ0FrLuup3-qUApdvB
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/16/2025 6:23 AM, Duan, Zhenzhong wrote:
  >> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V3 35/42] vfio/iommufd: register container for cpr
>>
>> Register a vfio iommufd container and device for CPR, replacing the generic
>> CPR register call with a more specific iommufd register call.  Add a
>> blocker if the kernel does not support IOMMU_IOAS_CHANGE_PROCESS.
>>
>> This is mostly boiler plate.  The fields to to saved and restored are added
>> in subsequent patches.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> hw/vfio/cpr-iommufd.c      | 97
>> ++++++++++++++++++++++++++++++++++++++++++++++
>> hw/vfio/iommufd.c          |  6 ++-
>> hw/vfio/meson.build        |  1 +
>> hw/vfio/vfio-iommufd.h     |  1 +
>> include/hw/vfio/vfio-cpr.h |  8 ++++
>> 5 files changed, 111 insertions(+), 2 deletions(-)
>> create mode 100644 hw/vfio/cpr-iommufd.c
>>
>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>> new file mode 100644
>> index 0000000..46f2006
>> --- /dev/null
>> +++ b/hw/vfio/cpr-iommufd.c
>> @@ -0,0 +1,97 @@
>> +/*
>> + * Copyright (c) 2024-2025 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "hw/vfio/vfio-cpr.h"
>> +#include "migration/blocker.h"
>> +#include "migration/cpr.h"
>> +#include "migration/migration.h"
>> +#include "migration/vmstate.h"
>> +#include "system/iommufd.h"
>> +#include "vfio-iommufd.h"
>> +
>> +static bool vfio_cpr_supported(VFIOIOMMUFDContainer *container, Error
>> **errp)
>> +{
>> +    if (!iommufd_change_process_capable(container->be)) {
>> +        error_setg(errp,
>> +                   "VFIO container does not support IOMMU_IOAS_CHANGE_PROCESS");
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>> +static const VMStateDescription vfio_container_vmstate = {
>> +    .name = "vfio-iommufd-container",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .needed = cpr_needed_for_reuse,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static const VMStateDescription iommufd_cpr_vmstate = {
>> +    .name = "iommufd",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .needed = cpr_needed_for_reuse,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer
>> *container,
>> +                                         Error **errp)
>> +{
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>> +    Error **cpr_blocker = &container->cpr_blocker;
>> +
>> +    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
>> +                                vfio_cpr_reboot_notifier,
>> +                                MIG_MODE_CPR_REBOOT);
>> +
>> +    if (!vfio_cpr_supported(container, cpr_blocker)) {
>> +        return migrate_add_blocker_modes(cpr_blocker, errp,
>> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
>> +    }
>> +
>> +    vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>> +    vmstate_register(NULL, -1, &iommufd_cpr_vmstate, container->be);
> 
> Will this register iommufd be multiple times if multiple containers under one iommufd?
> Maybe introduce a cpr_register_iommufd()?

I thought iommufd:container is 1:1 because of this logic in iommufd_cdev_attach:

     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
         if (VFIO_IOMMU_GET_CLASS(bcontainer) != iommufd_vioc ||
             vbasedev->iommufd != container->be) {
             continue;
     }
     /* Need to allocate a new dedicated container */

- Steve

>> +
>> +    return true;
>> +}
>> +
>> +void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer
>> *container)
>> +{
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>> +
>> +    vmstate_unregister(NULL, &iommufd_cpr_vmstate, container->be);
>> +    vmstate_unregister(NULL, &vfio_container_vmstate, container);
>> +    migrate_del_blocker(&container->cpr_blocker);
>> +    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>> +}
>> +
>> +static const VMStateDescription vfio_device_vmstate = {
>> +    .name = "vfio-iommufd-device",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .needed = cpr_needed_for_reuse,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
>> +{
>> +    vmstate_register(NULL, -1, &vfio_device_vmstate, vbasedev);
>> +}
>> +
>> +void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
>> +{
>> +    vmstate_unregister(NULL, &vfio_device_vmstate, vbasedev);
>> +}
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index ea99b8d..dabb948 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -460,7 +460,7 @@ static void
>> iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
>>      if (!QLIST_EMPTY(&bcontainer->device_list)) {
>>          return;
>>      }
>> -    vfio_cpr_unregister_container(bcontainer);
>> +    vfio_iommufd_cpr_unregister_container(container);
>>      vfio_listener_unregister(bcontainer);
>>      iommufd_backend_free_id(container->be, container->ioas_id);
>>      object_unref(container);
>> @@ -611,7 +611,7 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>          goto err_listener_register;
>>      }
>>
>> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
>> +    if (!vfio_iommufd_cpr_register_container(container, errp)) {
>>          goto err_listener_register;
>>      }
>>
>> @@ -633,6 +633,7 @@ found_container:
>>      }
>>
>>      vfio_device_prepare(vbasedev, bcontainer, &dev_info);
>> +    vfio_iommufd_cpr_register_device(vbasedev);
>>
>>      trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev-
>>> num_irqs,
>>                                     vbasedev->num_regions, vbasedev->flags);
>> @@ -671,6 +672,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>>      vfio_address_space_put(space);
>>
>>      migrate_del_blocker(&vbasedev->cpr.id_blocker);
>> +    vfio_iommufd_cpr_unregister_device(vbasedev);
>>      iommufd_cdev_unbind_and_disconnect(vbasedev);
>>      close(vbasedev->fd);
>> }
>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>> index 73d29f9..a158fd8 100644
>> --- a/hw/vfio/meson.build
>> +++ b/hw/vfio/meson.build
>> @@ -21,6 +21,7 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true:
>> files('calxeda-xgmac.c'))
>> system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
>> system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>>    'cpr.c',
>> +  'cpr-iommufd.c',
>>    'cpr-legacy.c',
>>    'device.c',
>>    'migration.c',
>> diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
>> index 5615dcd..cc57a05 100644
>> --- a/hw/vfio/vfio-iommufd.h
>> +++ b/hw/vfio/vfio-iommufd.h
>> @@ -25,6 +25,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
>> typedef struct VFIOIOMMUFDContainer {
>>      VFIOContainerBase bcontainer;
>>      IOMMUFDBackend *be;
>> +    Error *cpr_blocker;
>>      uint32_t ioas_id;
>>      QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>> } VFIOIOMMUFDContainer;
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index d06d117..1379b20 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -31,6 +31,7 @@ struct VFIOContainerBase;
>> struct VFIOGroup;
>> struct VFIOPCIDevice;
>> struct VFIODevice;
>> +struct VFIOIOMMUFDContainer;
>>
>> bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>>                                          Error **errp);
>> @@ -43,6 +44,13 @@ bool vfio_cpr_register_container(struct
>> VFIOContainerBase *bcontainer,
>>                                   Error **errp);
>> void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>>
>> +bool vfio_iommufd_cpr_register_container(struct VFIOIOMMUFDContainer
>> *container,
>> +                                         Error **errp);
>> +void vfio_iommufd_cpr_unregister_container(
>> +    struct VFIOIOMMUFDContainer *container);
>> +void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
>> +void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
>> +
>> bool vfio_cpr_container_match(struct VFIOContainer *container,
>>                                struct VFIOGroup *group, int *fd);
>>
>> --
>> 1.8.3.1
> 


