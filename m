Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94B6F54AC4
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52hT-0002zT-8z; Tue, 24 Mar 2026 10:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w52hP-0002zF-U4
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:25:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w52hN-0004ll-0W
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:25:39 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OCBxwR1156650; Tue, 24 Mar 2026 14:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=WzyYOaKJQuwMdpjHa2TrDrPh5UYqv9UmiWroY6r0jvk=; b=
 Ux6fkb35KpVMx8Qx9agc3hA5EYh/dGDqZNSnlu8uJUym5JoBSV+mixk/o0X+IF+L
 ReeOhpDS+bxPkkbVQ7qMjXgrLWMFBZaNC6s+VggOwSYE3sOzDIOR+TH0tNTggQCM
 aV+z5XyJ305u13oRV8L968a3ywP/Ca9qUJ1aRf6LdqubY0Z7OWVVQ8lHswwnYtl4
 LFNkIaq4HPkyHIQDjGI/73+W9MWxNLs5NDFgSYPY/ZP2uxwjLDhm3KFnounCf3jk
 rfZyeu9o8R8onz6jBCdv+0zAcnpxhhck7sfN37PFiWqNnuk3t/TJxXr5rtV9arGE
 qmwMAxFML15QqqZ1QTbBkw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kgfmbbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 14:25:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62ODGjXU007139; Tue, 24 Mar 2026 14:25:23 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4d1hs9q64h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 14:25:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9CrwqNHoUjNMtqaejtLju0FWC/Oh1aRVIxKrJFaQ0z6GW3B8EsuALUa4YCUMZwfPI7vZZ4o/w1hL5JqAQ216hAk2cT5F4+UahQiggbfPuQ4Ts8S+9qu9k9iw4thg2dSEgtJoaUDBlJLAYnulNRmsUZiReKiFv6teAhn0fVN4dxXd+9hXUvBMwspQrttki2kIi6TDQKBh1aqGFVKVIWFES7vDbnuAuaEVgC8usDC8MKF/jEtLY4Ke5DM4b86Tr3rjjH8nhM92azZOM4wgFhHcoEiuvn6hTkJyd9b4YlquIzodhpGo6deOz2hEQcOKS74wJCfEj1PafNwxfj8UCUtkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzyYOaKJQuwMdpjHa2TrDrPh5UYqv9UmiWroY6r0jvk=;
 b=r2b8GfJ3l2BZVkrrT0+N17H9kn87kXUr6QtglcRApsIzoQE3tjlEVKN1kGe3rQzFBCcV/v2tfBRMJYN7MnPeBVJNG7Y07ZyrMWa4t66dvLXwJPNLSsejQEWYMqDa03LoXyZ4TKj/i4AmQpkwa485rx1NRWyxNwDPVoMpO1vfuJKsTjdnMIb5zL6LMQ9GccJLESALfYLrTvpkKvtU1+2R4vqirz+4CI9LUq3AXWqs/dzBNn6jEBwXGHP1wzfzrYU011UWzjd9PmSkzPRAK4tDRtu6g9T4HZq/RqtM8y0jzg6StVkl8oV7Pov/C6Vy2Zp//SsYFB6Zl9jJxOXVotJudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzyYOaKJQuwMdpjHa2TrDrPh5UYqv9UmiWroY6r0jvk=;
 b=jJC4vK9XWoZ0rsTAwxjuRC4lHKfkpvBYp7NCRBIpA1I8MZokAmJr1upyUCdfo1Dt8zO4SdCHinzdUcac9pLb8MmSkYthJjicshZdCGzIgxchs5IrYTbFnKSEksHfate0o0+1+8jYZlRSFfH9tsXxBjMQHxGsZ9LOYVrcgdcOZK4=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by CH2PR10MB4215.namprd10.prod.outlook.com (2603:10b6:610:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 14:25:19 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 14:25:19 +0000
Message-ID: <ba2d7018-7dcc-42d7-ba52-395d4e1d0298@oracle.com>
Date: Tue, 24 Mar 2026 10:25:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] amd_iommu: Follow root pointer before page walk and
 use 1-based levels
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: qemu@demindiro.com, mst@redhat.com, clement.mathieu--drif@eviden.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 boris.ostrovsky@oracle.com
References: <20260311203943.2309841-1-alejandro.j.jimenez@oracle.com>
 <20260311203943.2309841-2-alejandro.j.jimenez@oracle.com>
 <2756c509-4286-444a-815c-d6266c3e3a91@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <2756c509-4286-444a-815c-d6266c3e3a91@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::13) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|CH2PR10MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: a277cf04-ec64-4688-2653-08de89b12d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 0PYfmIGYEjcxwYtMt8ZF5YerELayb+3B5GH15qTZgjtCcXJ4MrLTJGsC9EF/mo67qe1HZa2xxxVz/4/Km1dkXVcenNC9Eg/psggJkIRK5Nmyn79tNw37ZM150EqabL2TGIqBg/l6UpXNGVXeR/2g91CTOpYM64QkqS9anc6UsRjWF0qUxOtvln8/bs6PJPgj4bs2jRETADli88QvXYZ8I3yyX4dNQxqlHI93uIlgsxN0B9wqSTS0X7khAJHO5M+V3mFopH0/AVTk8WZV8EfzECNM/46GCHyD6JkG3vXXktU2rGowGHoayDlLmH1XEGUXKIIG9QlW4sxfxqOfCqbyQZnmq46jEO5CQ8yHKWvjnUUKiqJXUkntWsNuy/N/5Skfd8h2+/UHgKeeHRpRh4NwnCiBBY0ApEpMWIC+LXnQpfW1H9eYFA0lAzPUx/7qCuVFxsnMdmUyHfehA+GNlocXpLJiC1CbYF0FcGD6xfg5MVSPUxivdmiregx9UoKZGDQNLUryYoNdgJkzGCisWTNImSDNTSAa8BfbhePgF6iMMeyywL/oYhbWEpeHDiCpqb/2EvoIpnxym6iuszjqHwqE/m0KBdyBz6J4MwGee7e2b1yTx+TO5/NR90nm7WJWcD4diZUexhTKfWSiUbLPE2ou7uQpDA8lJ635RcIOK+kehiVxXfw8bKWyJl4dDk8vCbnnI8RFU8Lq6VUba42QKrL/NBnKQ8u7e6xJXhtmpohtyQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFUyOVNBL3FIaUtkeldNYWxxUnArNE4waXU3WG9iL0FCUkdSOVRYcTJXWXNL?=
 =?utf-8?B?MWdLc3R0Z3MvMXNKOEpQNzJvemdYbCsyR1Jleng4SmljWGhzS0hEOCsxaSt5?=
 =?utf-8?B?UGFoU084MWFPdFY1MWJ4cm40Ym1SdnlzUk9TMDNjeG1FMER0WThDN1dmeXdX?=
 =?utf-8?B?bFEwZkNyaGN2S0lRUEdSZE9vbms0eW0xUVB0UVRLR3Z5RERoR1NZVjhFbFNk?=
 =?utf-8?B?TCtHYUFCNGl4NVdlM2FsaHVJcTJxZlVjeGw0eFZvLzRyclRjOWVGK1RnaVN5?=
 =?utf-8?B?SWs3akl2bnlVQlhxSFc5UWVFQXI3VUJ6YjZrR3NUN1k3ellGcGVDYXZTWGln?=
 =?utf-8?B?bkFwclk1VzZsbmpZYW91SG55U3k0RmptL2ptYVM0WTZGN085YTgxTFo2WWlk?=
 =?utf-8?B?b3ZoOWZHOU5haUd5UzFJQkFRdUhTQTUxSkxwZzlFRFVTSEhlOFZadmkwRTZH?=
 =?utf-8?B?eVVvVHVRK0lPQ08rcEN6Y29pTlEzbU9XYnloWENKNGpsTHhuWWR4NDhtOFc4?=
 =?utf-8?B?Yk1xVE9yMGdPbGdab3U2cS9iak9TZzRYSEVsbkU0MEgzV0VncTJGS3JJYjUv?=
 =?utf-8?B?UEtlYW9oQTQvTCt4bHBoUmFZSDRuSjNpb3RIVXJaM3A5QXRnaWpjZlNZelNy?=
 =?utf-8?B?MzI4S3dFYStOSWZQVnN1cStZZXcreHhtcFNVRzhndE1CS3FidXFIYUY2VVZi?=
 =?utf-8?B?R1VWT2dmNE1wbjltMXQ0SldNOSt0Z2g1TVJ4UVRQRmZ5b2V6V2hQZU5KcU9E?=
 =?utf-8?B?NXFpL3V0Y01xb0I1TC94aFdnYjNUT1M3T0l3M2VXM0h2dnJxMytKdG9xdFJX?=
 =?utf-8?B?SGhqSm5FMkhac09vNVRsMGEzemhJYUZ1QjBXd3dONzVGY2lzOUFZWDVQUzZP?=
 =?utf-8?B?STkyWnlXOGpIMnBjV1d2NnFCbE5tSHViQ2dGdjU0VW55YmJFSVVHczYrcDZy?=
 =?utf-8?B?V0lrWnAvME5oSjNma2Z2dXQ2VWhjdVV3bEo2Q3hKWks0bUZRaFpDV01USm9Y?=
 =?utf-8?B?M0V3UWJPVXZiMXp4eVArUnVnZE5vSUIva1M4b3BESVQwZlRna24yTzJPb0NM?=
 =?utf-8?B?M3ZvT2tlWStteHptbk9wMkRxdC9lQjJDUWswME12cUlWNWNWMURjV1ZBM1ZU?=
 =?utf-8?B?N25BU1Y1WGFzbmZxdlBMMmtlN1hGOEdqWFUybjJTN1djY21Hd1VTMDZKb01X?=
 =?utf-8?B?OGlEblRGNlExRDYwMnN0eUZGQ1lVU1R4amJWOXl0QVBjRXRMY1dybUlKTjY1?=
 =?utf-8?B?VytLdkxuZktnYnpVZlRJaVg5cUdOK0VobThIMU8wZjlzV3JjazVEWitJMG52?=
 =?utf-8?B?K1JqYkhCZEo5Sk1hY0RJUTJFc2JHbEpVRWFjMWZXZk1RWHI4Q3RYK3REZ21C?=
 =?utf-8?B?NmFROVNsU2hpWHdMZGg2TGc1d0h3SU44WFkwT1dhN0lZWCtEdm1YNDZEU3VW?=
 =?utf-8?B?dkRHd0t6TjBYVVRzVXRTWDJ6bkR3RXBUR3luYWhpa1Yzb0t5blpVT2NlWkdp?=
 =?utf-8?B?TEpQVERmeWc0Z0ZLWnY3blpvaDdsaWR1aHU3WGR5end2UDBVTGZ5clM3QW5O?=
 =?utf-8?B?TFhRSmplQlJ5UmlKTXJONnV6ZTgxeWYvYWxXb0hJNjZNeHh1Yk5DVlcwUXRJ?=
 =?utf-8?B?VDEyOU9KQ3N3NUVCR0s1WC9hZkdEejRRdWluTmF0OTFVMEcrSzBWNFl1ZlpY?=
 =?utf-8?B?Z1dZajhFdlJ5YUg5cHJTcjBOZXNTOG1Kd01hWXlUS0ozZTUrY2JLem1FU1I0?=
 =?utf-8?B?WFFiYUk5aEJ6d2kwcnF3SWc4TWx5RUdpZUZsRGlPSTkrY09uUXpCcUNKZ3VY?=
 =?utf-8?B?QVZSMnpoVDd6VHQrS0RsWXk3NnZENHVrNVhMVVNzNSsrcHU0emFpUnc1TFpk?=
 =?utf-8?B?ZGhSWEJOaFU0OWRHaG9PRnQvUld4YTh6NnFlQzFmeE9SSUNRNVIwUVdDdnMr?=
 =?utf-8?B?UUZ0MTRUSHZRbm9TUWgrTisvS2dHQkN0TTdHaVB5SjdQL1dGRkp4SWJtdWE0?=
 =?utf-8?B?My9lSXBrWEZNOWdoRklNTlk1RUJMaTJsWjNlbjNZQldEdWRBQmFqOFZTcXVE?=
 =?utf-8?B?enRsUElISG5QNTluRWxzRmVDa05aVGliVXNOSUc1UjcvR0R6UkRNQkhaMDVp?=
 =?utf-8?B?RkpWR3poR0FkWlFTOUNnRG9CSytSdGMwUUFBRUpySnlCNUtYQjZZQUltOHBh?=
 =?utf-8?B?M0RKV3FjSFJQVEZqRkhGSVFuOW40ZXA3MFJBZmp3bm5CbXhTOHI0R3ZTWk9I?=
 =?utf-8?B?RkRVeDFmcy93L3BaVGtycC8xWDFvWVROU2orTE9lZ0g0MDJ0ODd2bUFCNWc5?=
 =?utf-8?B?OVlwVFI4dHYvNGRmbE1HS3Z5WnpkU3dPdXEvbXM4emZxZWNCOFFsKzlYTjRX?=
 =?utf-8?Q?NiG6CL3mz82uTk7A=3D?=
X-Exchange-RoutingPolicyChecked: Z1jDcV7ZrFaBT+LNfDqWFQvsgFRplwQOIYNk0sRFJspyMt/18/K9mQdINxDZx7PSWw02HXQHiHVApYAuZIgEzRMJkL0C54I2Szy78M0XnNMP3aKR6qW3fe/+XEsWkyQptpoSlLdfN6mn6gGoaW8LDXoDuZ8QIuI/LXou7KUE6evxTxZTnEPkV8VIrB8gqIoDoNQR9DuIxBG3/a3MOP/J6kh26fc3smcSOcdFJRweWckq+SFEtcEb3Z4Sgj4XO7XYlonKihSzOI2OfZR3VbSdAoi6EwrcWuE4K273DXt7hgv7lDmS3LbzQva1j3krPYoE6WOLAb8KYtw87sf/GThRHA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MSUcFsUO1XUdartt8ID0/hGfEtyLwe1pzQsb+5e6IEDqPMpfVUlmlP13EibBLpdSdF+UyRYUAQ7mdvIeeQrvgTUkzHgOyHE+7DPF1KRjxJcytk/s9xrAG4MBz2ak6JU3rqvj0TggD9F5/Vlk6gFJiVEBnMJLm3qwaGOk8A33A1pGHGbu+irscfEcKSkqisMTwpQ3Llv/5d57vAJYH/fN0a1hjwt55+XGUYyGt+bIyZO9zqY4dUDunGrzWYbzZbpY/Kuf0WfWDvrxq4etai6oFXmwqiurSx5uIJpMBvNidY+KHioypEwTsjOuwXGnnhRejfK7nOZcBkIq1udpP3a/PuUeZyVzQT5GxMJxZAM7bRYbRAt8iMmigL9nZYfhReeaO8THqSPbrP6uWXXZfPvqcqaJYTnM7G1tKx43VwEC+daamcYj4iv+z45GA/RX/PwUXZNevRGf5sa/Sbvviw5lpQ9T6xITVgCo5E52uv8E30PxYtDekkr+j51Jdd8GHtUgEXJiRK4bQojnJ7/Dyw5TBmURJp77fdJ4hW7d/JmC6npAyUgJ/avX2ytJwrj4U++OvAmfsz1xH/2zfwtGCMGLcLyFFdaABFHo6BRQJ5zZqqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a277cf04-ec64-4688-2653-08de89b12d15
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:25:19.3956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JcSBmWwaFEbJzsa4GrfWkxRKGoUV5WRf1CjJatPQ7ixkWkt/KmWehizaZZTB+B9WDtHIy6ZyeP11rYPwF0/uZwBWfnES4YsziydLJb8QZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240113
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExNCBTYWx0ZWRfX4bDVBFrnc2JY
 zHPd2f19ku2oR3IEHY95DC6k1apyDUbLbvdV5QrrPTaOmDSerBP51IxZSKeEtK5qT1tSkgm3eje
 lb+lxRbPVQXJVjJfN7mCEsAL/MkaQvnjEjpEX1LHIrzE9Eu6rTPjNxBzeJ0Ru5nkp+QtpFzkvvW
 syoR+Gu5CzU4b5Q9WGc6r9gtbjJar9YSKGXN8GM9fHr8jfXOoVVsKRDCZ5stj9E66qDvW2P3tFI
 6PA+NTrPE26apxMymvp52JaB/Eyq80JXbXFK4w5esFf7WXs90RngprQRybM64RTEOmnK5fTmVkB
 ogQq4XhSEDc3pqp29uIFSob5Ybi4HPSzrTE6h0XJ+9asseDP1MXGZL21IPMtyId/76ims1ohwH0
 +Lz5axB7jR30HB9JQ1Cy1E5IBpcWeaMimDd+bkxX71axX8ruFQPMhE8oYe2Scm84S7pWn15vPuP
 2sjo5BKAq0nMjSWm2zA==
X-Authority-Analysis: v=2.4 cv=aq+/yCZV c=1 sm=1 tr=0 ts=69c29ed4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=69wJf7TsAAAA:8
 a=RWxpEp7VAAAA:8 a=yPCof4ZbAAAA:8 a=q3gGEZLLbp5tZrWB41oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22 a=3unh6Pbajv6CBnL1DxgC:22
X-Proofpoint-ORIG-GUID: j969-DCFr1ZEyxQCbxc1-Z2bQylo9Qnz
X-Proofpoint-GUID: j969-DCFr1ZEyxQCbxc1-Z2bQylo9Qnz
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/23/26 7:01 AM, Sairaj Kodilkar wrote:
> 
> 
> On 3/12/2026 2:09 AM, Alejandro Jimenez wrote:
>> DTE[Mode] and PTE NextLevel encode page table levels as 1-based values, but
>> fetch_pte() currently uses a 0-based level counter, making the logic
>> harder to follow and requiring conversions between DTE mode and level.
>>
>> Switch the page table walk logic to use 1-based level accounting in
>> fetch_pte() and the relevant macro helpers. To further simplify the page
>> walking loop, split the root page table access from the walk i.e. rework
>> fetch_pte() to follow the DTE Page Table Root Pointer and retrieve the top
>> level pagetable entry before entering the loop, then iterate only over the
>> PDE/PTE entries.
>>
>> The reworked algorithm fixes a page walk bug where the page size was
>> calculated for the next level before checking if the current PTE was already
>> a leaf/hugepage. That caused hugepage mappings to be reported as 4K pages,
>> leading to performance degradation and failures in some setups.
>>
>> Fixes: a74bb3110a5b ("amd_iommu: Add helpers to walk AMD v1 Page Table
>> format")
>> Cc: qemu-stable@nongnu.org
>> Reported-by: David Hoppenbrouwers <qemu@demindiro.com>
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   hw/i386/amd_iommu.c | 132 ++++++++++++++++++++++++++++++--------------
>>   hw/i386/amd_iommu.h |  11 ++--
>>   2 files changed, 97 insertions(+), 46 deletions(-)
>>

[...]

> 
> Hi Alejandro,
> 
> amdvi_sync_shadow_page_table_range() does not check if DTE
> **valid and translation valid** bit are set. I added this check in
> my reply to david's patch. Do you think we should include that
> check as well to ensure that only DTEs with **valid and translation valid**
> bit are passed to the fetch_pte ?
> 

Right now the check for DTE[V] and DTE[TV] are implemented in
amdvi_as_to_dte(), which all callers of
amdvi_sync_shadow_page_table_range() use to extract the DTE that will be
passed as its argument. So I think if we were to add a check, an assert
would be more appropriate.

On the other hand, I am worried about sprinkling assertions around the
code, and I am actually considering removing the ones the original series
added to amdvi_sync_shadow_page_table_range(), fetch_pte(), and
amdvi_notify_iommu(), since any failures in these cases are likely to cause
immediate symptoms and I don't believe it creates any window for data
corruption.

With that in mind, to answer your question I would not add any additional
check on amdvi_sync_shadow_page_table_range(), and would rely on the
current convention to check when retrieving a DTE via the interface we
provided for it and all the code already uses i.e. amdvi_as_to_dte().


For a follow up cleanup, maybe amdvi_as_to_dte() should be renamed with a
more suggestive name that clearly indicates that it validates for those
conditions. But in context, all of its callers rely on the fact that it
does this verification and its return values also encode it.

While looking into this I noticed a chance for minor cleanup in this flow:
amdvi_do_translate()
    amdvi_as_to_dte()
    amdvi_page_walk()

Where amdvi_page_walk() does an unnecessary check for DTE[TV], that
amd_vi_as_to_dte() already ensures is set.

Thank you,
Alejandro

> Thanks
> Sairaj Kodilkar
> 


