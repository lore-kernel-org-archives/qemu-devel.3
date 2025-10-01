Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202BBCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 19:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v42Rz-0000Gm-EQ; Wed, 01 Oct 2025 15:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v42Rt-0000F3-K3
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 15:25:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v42Ri-0004rf-N0
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 15:25:12 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591I0njs000557;
 Wed, 1 Oct 2025 19:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=6OGQIz5mKmhHjO499OYPoPzVN4ybOekXX6muF9fn2N8=; b=
 C7gR6CAW85n47HB/vP/kyT3FkDX55+Min+vds+oLV7Y+kWvoHKCSimR1PI51f5p0
 1sr+UMLpUON1Unn3ZeBdVGVkANTE4jSGIE/HMIXoYGYWBHdIOAlke4sKU8cTr4b+
 bMmh9oWYYqxd8PQ6NE8CVW6dethmNB8Sam+QdTwtCfeZB6UC/zh8bxbd6qphBuz3
 JcpEniwawzmNFDfFdBhPqxJvR2udUAxU/Q1lo6c/9XKqLN6EW6JyiWsQiB9ru6Cv
 ZkpFCoJFgaQiitU31EGnQi2Y/i3CacCCHMuwOgsdmtZOnNZlmvfUDbV/M6Iigo+o
 vxj/qgX6Et2+lqEtITxu6Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gksxa6h9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 19:24:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591IVtnc000334; Wed, 1 Oct 2025 19:24:51 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012053.outbound.protection.outlook.com
 [40.93.195.53])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6cg4c92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 19:24:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzP+a1yl09N66EwkR87SW2evxc+6cr58r+dFDuedHaEEZG+eliPwvYMxeZljUPIZfsyhI0IqYKJH72vuxkDEGbmTsWdh8dqW4gU1pPIIG+VLNRYH+GBN3dEROCTspAqQ0Z/5ja0TdHew66uJyIE1OTsIOOONhQgOxkAg/57IQX7Y1Wa3cZraXwkhovVwtCSEKriCae1o+pbXnKFeT2TGqTrjCtbIUcXqW5EtRFVjs76SMdbXI+AF1twdDoXZJH4jPP93db6utwVsdlg0Wlz/PGlUpJDI/2brU0PLiFz+IBxZOGHfLGCAy1yY52bwj9I2gvkgDumRq4cPy7uN/hXQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OGQIz5mKmhHjO499OYPoPzVN4ybOekXX6muF9fn2N8=;
 b=EwThAcR8zisr/DCgYX1AAttFFUIqjq1ZMp7vgXriJp44/OtUB/Fj16iYQrB3369nfgxzFc1p224lCLHAI0HaRcPWQyR8TsZZnznKxFvXq4mptCufAtr+KdQ6eIgKtU/oLE0PgLbCwyAREQvz8bqkstOENrs/XFv1w78aXDhTx8cV5E4ZJqKt0fzvG7DosDqIyTVwpvuyIZGs62HqnUa3V8KlZu/yReVVt9Z66oUyJ2zUUCv1ECbY4KLohSEhMJA/u07hchD2ptTqv0hRJcvTpx+Utl6LhpnN4+PjrCXjKzkDkxJ+p1ng+f2iaauJQ9qG32Pm9CIJVZTzdCeWiFOLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OGQIz5mKmhHjO499OYPoPzVN4ybOekXX6muF9fn2N8=;
 b=kuJc2QWeTNefIn7sC13usrefs1LVrbqI4gb5+lHTICAhAuxBqxquw3EqAZx0G2hJoHN3EJBvO9xwN/GHBWpMC1IWs2Hd0Afu/q7xnpjTAccIpY7rMTnNzs6sP3HQmi5AvnC86mMHM0F038sEWHYOBodf4oRSUp7mURXsFLlog18=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH3PPF3B2A83235.namprd10.prod.outlook.com (2603:10b6:518:1::795)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 19:24:48 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 19:24:48 +0000
Message-ID: <d91186b6-24d9-4b3a-a4c5-d68445c267bb@oracle.com>
Date: Wed, 1 Oct 2025 15:24:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/19] Live update: cpr-exec
From: Steven Sistare <steven.sistare@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
 <aN15cNEwH4HBt7NU@x1.local> <c7ae8d4a-05ee-48fe-8edd-77dffecf2c32@oracle.com>
Content-Language: en-US
In-Reply-To: <c7ae8d4a-05ee-48fe-8edd-77dffecf2c32@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::29) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH3PPF3B2A83235:EE_
X-MS-Office365-Filtering-Correlation-Id: ab34d1b0-2770-42f8-43da-08de01202fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXB3OVZjMzZXbWpTeklZaHlqVmRyQUhBNVhPMmkram5aZ3JXbGJiWm9RRVV0?=
 =?utf-8?B?ZUp6WDVpbEQwRG1uYVUxUnJoM0t5dnFYNFFyVDFsajdYa1JHRFJHODZLMzNi?=
 =?utf-8?B?NUhEeStRa1cxWlhUc0FkZktsNVJzY1ZJbDhCUC9mblhaL0ZTdUFHSXJpNkVZ?=
 =?utf-8?B?VVVZSVZVVG5LQytFMDkyeDE1NW9Fcnk5V3p3MFNXeWRnQnJDOXRyaEp4Z2pV?=
 =?utf-8?B?d2tvaGxlb3ZsTWIxZm5HRCtPODVVRkVPUVhVb2kvRU1xVW45T1NHSytmRllV?=
 =?utf-8?B?dGdlajJmMFRCQkcvTklSNWtGTWE3UW5CcW1Eb0pyNmZNRnFRTUpJN0tmTjU4?=
 =?utf-8?B?Z1llNlYvSlBsQWNvZk1YZzJXdTlYK2J6MC9VL1VGMkVCbFQvUlpJaGc4NFdp?=
 =?utf-8?B?NVJRTTY1cC9yZDJGbmhnazJVSzd5amlzMnhVc3VXRGVsaWQxTndpSEp3Wk1z?=
 =?utf-8?B?RG16K25QeFAwM3hhbDBXaFpQcUY0U2tDNFM4UXQvUlVzaEt4ZU1LNHNhcmJV?=
 =?utf-8?B?VFRwOXdvZ28zOEl0V0U2aEpHeXh3VzByU1d6WTQ5K09VQmwxUmFhVzc3WTRm?=
 =?utf-8?B?elc4TXlNT0NFUm45OW40b0RDeEZMNC8wZTVuYTE0OUhpNVNwV0ZzeXZZcThR?=
 =?utf-8?B?UWxza3hPbUFJUG5PTHFuUlM2OU5hR1NNeUlpcWd3T3Axd2Y4Qnc2dnhYMEls?=
 =?utf-8?B?clNUVnlLeEdWSisxN21JRStDNnJVb1hrNEd1R2NkMHRZSEtTeHJGa000cEVa?=
 =?utf-8?B?ZjlXOFVaV0tZT1o0MHA1cW1QZ3RjTk4wbFJsRU9OQUVQb2wrdG5UdGlReHgx?=
 =?utf-8?B?b2hSdytGU1RYQmM0WWtRRi9HWUQ2dkt4SW9TTVpWSWoySnlnZHp5bGpDZUtj?=
 =?utf-8?B?U1J1am5WRHBVcm91SlgxZnZEaGJCZWkrUzNXYnJaU05lQzZpZHpnSXdZUmwv?=
 =?utf-8?B?YTZTWENxdFYvczdjRFFUck55OVZicWlTQjczQ3JTNGw1KzVZelc1elZRNGY3?=
 =?utf-8?B?aFdHcFdLVjk0UjBKSWRuWnpQVEp4VVI3QUNJZ3BDVEtyN3FHV1p4NjlBMSt3?=
 =?utf-8?B?QmpBN0RYQ0dHRjVQOXpiaFEzTXZjSExCaEZmdlBLdW5QTnQrMmplUzhwSFdY?=
 =?utf-8?B?aG1PZlFVRENNWGh4cGtMRUNXRUkyblhua0tYRFZTNjVYL2hyV1lnZXdkQ3kw?=
 =?utf-8?B?T1JyQlFmMW1pcWJvODd6aWlYWmRNNmlTaWJoT1o1N0k3aGY5YkU4T3UzSHRt?=
 =?utf-8?B?SEtUUlJPNytnWFBYQVRUdWREVkUvSU1NWC9lcXkwb2M0enlHamNPWm5aSVVw?=
 =?utf-8?B?TTh3cjgxMmxqb25HVzZWbzMzYWVTZVFhdzhNUmF2dmluN0swam5WOVJpQnhh?=
 =?utf-8?B?bFJtTDV4VVBVb01EVzNhb3cvSEZIS20yUTkrVVFKTnZBbFB5NWFjbGhQcVlN?=
 =?utf-8?B?NzlYMDNybW5NSXd4N2ZPWW9tMFdKRE5ySFdCbW90azc1cjZCVGJwOWowRFJk?=
 =?utf-8?B?MVlEV1dYU24yN0k5NDhIZU50RmFQK0ZnSW5YdU1wbXhpb1FobzdKek93UVow?=
 =?utf-8?B?ZE5uYWw4cUdXTTNoVXAxRHd3SUNCaXdDRUtwdTMxbGVObzlsdENHOEExV1Ri?=
 =?utf-8?B?dHpVVm05VzI5Ylc0cGVVN0xxcy9ZTE01VG5zcFBJdzdiVWVaSTQ2ODB2QWo0?=
 =?utf-8?B?UWtKQzBBVFBWVmFnT1dpaG5CU3JCRnFYZkYzTm9ET2lVWm94RHpwZHdJbTAw?=
 =?utf-8?B?Vk5jaTRuL3pGMzNwb05WQStwVWRNbzBXam9Kd2RoUlc0dHhJRWlWL0oxaHEz?=
 =?utf-8?B?aGhFS1NJYW5BdFNCaGxWekNCYTJLc1BJNm8vYjV6OU9oZDhYVGpVdmNLZUJz?=
 =?utf-8?B?cEZWRzhad0RNUkRQbHBRZUN5RmJnV2tjMHUwN205c2Q1YmJkcEpiaWFzM1pG?=
 =?utf-8?Q?/SZHckmE39ThCDoCLPIOyM2t2GRyqHiR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2NpNGU4NnVlU3FYM2tQNm44NjVYazlTTUU0bnFERXJ2M1dobHNVbit0ZjlZ?=
 =?utf-8?B?eEJmcEpybFFJei8rSWprOE5KWDA3a1ZNVW1LaGtpRGExdDQwK3NZaysxWjBR?=
 =?utf-8?B?c05pTjJ0ZndmM2JSeDVxcWcyK29HbVBNSEV1MllldjIxYS9JU0J6eTFYRFJh?=
 =?utf-8?B?R1hQYXJuM0lNTHhKMStNUUx5bnVoWGJaSHAwNkpCSXpDa0NUR1RwaStkSDZE?=
 =?utf-8?B?MXVsQ1ZzbGlxeEk0b0JFZ2FYSk5WSFBDS0pZVTZVekdveFlnWEhGQmFwdzNQ?=
 =?utf-8?B?RHFsYllxKzA5V0dYOVVrc3lITlE0QzJybUp2bytqVHo4SnU1U0pyWkEyaXRU?=
 =?utf-8?B?VXhlZFREWE5pbGpMSlRJOSsyMFBXaGVyaTRsTzNOYWZPc21mVVlRZ0hpVDFo?=
 =?utf-8?B?eHB5K3dTdUZiZk0rbjFIQlBNUlExZVdoMGl0ZmQ4MGhya01VVU9SbVhLeVBj?=
 =?utf-8?B?THNUNHZGWjkxTXp6eVYwM1lNai85VFQyUE1kRlJLVHVVbTB2QjJWMER4a1RX?=
 =?utf-8?B?dmZyWTVGTEZLd3FVM09jUERzUjFNY2NTRGRreENHb0hWYjdnV3YwVVVSbXVq?=
 =?utf-8?B?bnRFNS9YTCtwMGhRWk9uRGloa3RFbXFsd08rRTdHUVNWcDZkM3BITkRxVjdY?=
 =?utf-8?B?Z3NONTVYZTBvYUlUZzZKYm9VeEVVV3JlTTNPVEQvYVJEQlh4RlNLYnQyd0Nh?=
 =?utf-8?B?R2djdWhFM0xIUGZpVUIyRWxOS0Y3cEplOVN2Z0N3RlFIOUdQWllhcGpzOXlk?=
 =?utf-8?B?TjNMUFhSeDUyc2F1QmJ4TmdWVUpFWE5XV21SWWZsNXJqbjNYWjZiMUJTRzFx?=
 =?utf-8?B?R2E1eHgzVXhCV0tqVnlJVVpWclFhaldWNjI3c0ZmcmlPOERjU3MzeGZnK3R4?=
 =?utf-8?B?MEtEcWxEVU4rMXVuVVBSYityLzFZTk5kZzhsOTljOGdOMUg1ZXRUVzBIVHZy?=
 =?utf-8?B?U3lNN2JndWwxRmJ4WnlMTWtra1NKcmFkaHUvOGVaMFFzaFNqRGliS3NOVW5t?=
 =?utf-8?B?bjdMTFBVWHZ6YisrWGtHdXcrbng1QUNaSVVoMGpSZ2l4d3AvbkhGZG03T3lQ?=
 =?utf-8?B?eGh2YjJPSkJOMlhORElsUU9mOXRSTTR2bXhma3FJalhKVERVSW1aWkFEU3pT?=
 =?utf-8?B?ZEdrR0k5NllYTk1RancxWFlBQ3NJTWFhSVBSNmNudWt0dmZnMGh5QWFWUzkw?=
 =?utf-8?B?WDNMc1k4Mkp6VE5zdlhQQUJjNGdZcGpqQm9DWVpJVHBJYXNIUzJ1TVJOSzFP?=
 =?utf-8?B?cVJGWjJ5RHorK3VBVDBkZkkxSFIyZHQ0b3pES1dCVWFFZG5XaWkyWGxMeUZt?=
 =?utf-8?B?VGpmcFpZNEFnUXRsSWpZeFVic2xOY0toREJwK0s0M1FXQ2RIcTRJTEg2ZG9x?=
 =?utf-8?B?NWk5bTFuZ1p5K3Zva2dEV3RNYVBpM0lJcnl1ZThhVTBIMmdPTENIRys4dXRm?=
 =?utf-8?B?bTJJQ3BQbWx5ejZUSW5aZGtPOHdpS3RoNnVDb1dsbnI1SWlXWWRpZGxkcjdT?=
 =?utf-8?B?R3B5TXhzQ3hpN3lhNHViZW85M0hrY1pOUGN3bmJCdE8rOHNURnVqYy9LNENW?=
 =?utf-8?B?SzVBazRETU1lUzRpSk1tUFZIczU4OWNlMm1zNEhNSnBtR2hCdmo5bUk2N1ps?=
 =?utf-8?B?WVFoUzNrS1hkbnlhMDI0NEQ3SVVkNjh0QWNtTUEyV3NPbWdzbi9rL25iRXpo?=
 =?utf-8?B?Q05DOWFsTXdLcElDRU9HS3ZaaURwWnRWS1VrNHp3YkJFbjFRb1B0SkwzcU9a?=
 =?utf-8?B?R09yTHVmNG5QYWRqaEtNeCt2SlZTYTZpdXhreXRBYVdRN0dkejV6bmYyQURR?=
 =?utf-8?B?Um1kUUhici8zY2JEb1lpT0dDS1duanA5V3RhUlV3L0FxdFdzL1p5UmNxOVVo?=
 =?utf-8?B?V1hTZHVGZkp4a1FzU1JGZzAyeUVDWWw4TXhaTGgzRFZFS3BBeDNTajdxNmJP?=
 =?utf-8?B?cGhoRU1QV2lFQXVNWXdteDZ5dVlwN3NNS2VLOFEwVG5HaC8wN0p0cms2V0pS?=
 =?utf-8?B?cks2L1hCSmsvNXFpdWRWSXJhWXV5Q3VmWlF0dm9CTTdrWXdjaUJwR21xYmVj?=
 =?utf-8?B?N0pMSmt0WC9JbDFGOXpWeVVIMUswajF6cmVQZVR0UnE4Z0pHUjVzUnF5cE84?=
 =?utf-8?B?aEFmTlFYMllYcUdOcnV4dXJGZi8yd1QyZ1VsM3JacmpiUDVyVG9ZRFJoTVpS?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kaJuAz3PpT/hPhC7Iq8Gsk8GWPEHKw01pNQVT9i332Q+cpbs8ZzvBYAOz0kPIHjBdrDOMuMXxz9mzKYCKSdj3cJcFBIXiv0SJg+FbAThReomLy3ak/CZM2DxXJhxeYyGYEGif6Iv6U33bT8Dz4ZW9yPTiU6yoqDVpLc+j6yoyhZ7IXC+YnilVdLGvlFoXyoMjTM9xovPAuLj9IRK76yPUqDkhonl76TuSfsA6UCbKzp80jzLqWJDFKBFOnUk0OK/MJTAdoA9xs4EVWrgUrNuySMidlHYUoYVUHf29JwTRno32L+C87li7jKBVI+p5d5wrWVdIMcWY7Y8pJWYjz3jbs19iCbpvKDWxJuHW8ebfdTIMx3dKFeAZH+M4KOsyMrHfLmxfIIEikknMFQYLzQOkFYtldQASn0gUag76R5wM5HQClGdYd79aPm+iScu5g1yvMuIZ2/NlV1ljWwCwJmPi117CDYlb+/QafJqqT5ajidNJushthp7hlPp4/VLqqB2T1YxuQ+yK7bpUTbgWNeHQLBX7KskCKv+T4bSgftODVmpbXZSiG7lycXK0AySTsaX7PIFrOGaUVxjGiHWg7qOZi+AUyIijWRZYB1AZInz4qA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab34d1b0-2770-42f8-43da-08de01202fb5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 19:24:48.7077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUDAhsvDjJ+0OywdK3+zzlHbImdO/sLeQA2bkEBumoI+VpR4+T2uKjk3IAVS12cSxQj/pyYTXILKwtcys7JY8AfzoZpahIHFTpy/UfzCKy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3B2A83235
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_05,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010169
X-Proofpoint-GUID: cwCUCjf4fEWx1f5p-shcFhjB2Flwy07m
X-Authority-Analysis: v=2.4 cv=N4Ik1m9B c=1 sm=1 tr=0 ts=68dd8004 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=p0WdMEafAAAA:8 a=3X7RROFyK5nKA-wJzxwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12089
X-Proofpoint-ORIG-GUID: cwCUCjf4fEWx1f5p-shcFhjB2Flwy07m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MCBTYWx0ZWRfX+st95ImLiR1j
 gFhT2FD0qqyhNKQfBaLwj8KPwwl8ly7cUAEymVBrA/3CjmStM/EsowDHLHWDTb5JKqIgvCr8VRK
 6/EiqfNMWxf4jRvWwfIliwpke4gbBzhI4hPTtT+ImUL/0pKUWnUm4PCmXTWNsWbGo6xq8X3HroS
 lZyEW+q27dQanVkcRlq82cgDZTw0LP+5kON7CR08Ccm7z8xotIPy9uATo+CrDVnUXMbCyxrUHWG
 0YaWM4QMojZWddGQH/AruOthKrU9fiT8EktHZgo5X5v/2xIECp8UMdmm328bylpmxO3SxZxsd9E
 J7M0pJWeebeFcrGNPRuZIfnl0oDm8bqefxUCbs4HTaFNlF4AacwEpkwdZFWnKIuKiTYG0a5NGdH
 247D51cVNqOHLerY94OZAHMciAAbt+zaRi6C4tCSz3ik/Xewbq0=
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/2025 3:07 PM, Steven Sistare wrote:
> On 10/1/2025 2:56 PM, Peter Xu wrote:
>> On Wed, Oct 01, 2025 at 08:33:52AM -0700, Steve Sistare wrote:
>>> This patch series adds the live migration cpr-exec mode.
>>>
>>> The new user-visible interfaces are:
>>>    * cpr-exec (MigMode migration parameter)
>>>    * cpr-exec-command (migration parameter)
>>>
>>> cpr-exec mode is similar in most respects to cpr-transfer mode, with the
>>> primary difference being that old QEMU directly exec's new QEMU.  The user
>>> specifies the command to exec new QEMU in the migration parameter
>>> cpr-exec-command.
>>
>> It turns out I was right where I replied to patch 5; this fails the Windows
>> build.
>>
>> Smallest fix is to wrap qemu_memfd_create() with a CONFIG_LINUX ifdef,
>> returning -1 to mfd otherwise.
> 
> That does not make sense.  It already does that, which is why I used it:
> 
> util/memfd.c
> 
> int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
>                        uint64_t hugetlbsize, unsigned int seals, Error **errp)
> {
>      ...
> #ifdef CONFIG_LINUX
>      ...
>      return mfd;
> #else
>      error_setg_errno(errp, ENOSYS, "failed to create memfd");
> #endif
>      return -1;
> }
> 
> Did the windows build fail due to a different error?
> 
>> A better one is we only include cpr*.c in meson.build if it's linux.
>> Personally I'm OK if we go with the smaller one as of now, however then it
>> would definitely be nice to have a follow up series to reach the better
>> solution, if that makes sense.
>>
>> Feel free to use "make docker-test-build@fedora-win64-cross" for verifying
>> the changes.  I hope it'll work for you, even if for me currently it didn't
>> work due to a gitlab.com dns resolution pulling dtc src, where I didn't dig
>> deeper yet..
>>
>> The other thing is, this series doesn't apply on master branch.  I didn't
>> feel confident to do it myself on the vfio change, please have a look on
>> both issues.
> Ugh, they renamed everything.  I will rebase and send V6.

Actually that was easy to resolve, not worth a V6?

In patch "vfio: cpr-exec mode", drop the change in container.c, and instead
add MIG_MODE_CPR_EXEC to container-legacy.c here:

         if (migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, errp,
                                       MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
                                       -1) < 0) {

- Steve



