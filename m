Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24003FDEE25
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 16:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFwly-0000He-LJ; Thu, 23 Apr 2026 12:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wFwlq-0000HA-Gp
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:19:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wFwlh-0006lB-4z
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:19:14 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N6BWAM2586195; Thu, 23 Apr 2026 16:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=fr38XFTjyBT2VPxidzpfZP8N+S6TWNoI+9OpudCettE=; b=
 eWiTp/gR8ufdsMC5nL7BJE4pX8nAwlFuhvL/TKaeySDxQku+1RBlbca/QkxqOt0M
 noc+WqdTyKXm8j3t506iLouEdogaLp5ZNoQu0Sqtf9vgpDK7FTDSV0wsr1dwHb92
 dhJUdoYJ7xdqV+UQ3FKy9SqqVLsU5eMJUA/mZSqI5hsu2NoI41Yrj80Cc8/vb2/W
 L3N6xlcsyFvdpdG7i61TbtyDkDUS1iDJeQjmJmWkrnc4p+7E8aA1QmELmd3xGv7Q
 8eJvLvw2vIkN+yMqoKRylPCdK9HRQcnkxb9l+OCyU5vYKnrIzRjbS51ToSoXq0nV
 KyZIER9PBYNfFRn24A9y5A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dpenrkssq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 16:18:39 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 63NG6DGe008391; Thu, 23 Apr 2026 16:18:39 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4dpjjg3jtp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 16:18:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MA72Yv+AuxxNYhuMmCyYLU627Uk9UOyiQIoYIjNqsz2B+P5fAeEUKIp1cZmYA8RiPMq6VuUMBogIzkWWTYwR83hu/6/1tUi7xQ/CmV6G+u1LdOjHdwFoSskVK/EgpFre1R94bk7mNvc4gDddzc0bUXTuh1fF623DxoyMF4qGIDoxYWeBWTcgN3KKUfF3d00byLZgqQHxi2MoC65TPZyIUZW1/8LqEydRAgJdJyN1uT8Ymzits6rlAZLtmSyRQ/AV6C1iaV3WIX9m/pgSfgr/E9bd+meA97luxNoif+8zE1G/6LucNWmbYdAGaffL3Eqw63ghib3tD1zh8OuzSk3cIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr38XFTjyBT2VPxidzpfZP8N+S6TWNoI+9OpudCettE=;
 b=r4mLgouwVav+JhGHRArVmYWym9rfJvYktgPU4N8PXOlfnCuXeHlA6MidR+BXCZyrWfJgQ17srnLbXD598vvmtpNzRH3W7hzRAtubCuq48b++pjxNYRc5iUCGxJs2xVbUbtrtDOpb248WfIwQfFtIy4JbCh5LmMNShkyjtaB2VBu0USAKEs0zuV5mmQI54yntWLvvR9Y2rvzWKxg9vG28rxTxPSIgJYQDspKa/SQdbHrTaZP/qQJ6NWY1Qd04m3G87eY0L/TlX7u5Op1f+edXUyqELYE2w9QdVGANSREf5HZqbAyG2jaYALCeuuOVy4jyvNEfgV3P5Bf8p9WClPTeZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr38XFTjyBT2VPxidzpfZP8N+S6TWNoI+9OpudCettE=;
 b=Eg0U+JcDx8Y3K4ST1i3XtlwiChQFhg+mD0lsKWeBDY5X7zZ9VRh81OmDghcjuZTUA/LjwHKUSWpn+yEBJZKOqHBey9/F8JzkKKtfLBFE3B6cmlYThJwRsUPnHo0WVgT6IlZYX8W1a2pqawVYA+DBzvfs6k/mAA1PZeTBsKuASoY=
Received: from PH3PPF1D715CB68.namprd10.prod.outlook.com
 (2603:10b6:518:1::78d) by MW4PR10MB6654.namprd10.prod.outlook.com
 (2603:10b6:303:22f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 16:18:32 +0000
Received: from PH3PPF1D715CB68.namprd10.prod.outlook.com
 ([fe80::f1d0:317e:4337:b516]) by PH3PPF1D715CB68.namprd10.prod.outlook.com
 ([fe80::f1d0:317e:4337:b516%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 16:18:32 +0000
Message-ID: <7d1f5197-744e-4b06-bbf4-6c85b3bc741f@oracle.com>
Date: Thu, 23 Apr 2026 12:18:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Several QOM objects crash on introspection
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, zhangckid@gmail.com, lizhijian@fujitsu.com,
 jasowang@redhat.com, arei.gonglei@huawei.com, zhenwei.pi@linux.dev,
 pbonzini@redhat.com, peterx@redhat.com, philmd@linaro.org,
 berrange@redhat.com, elena.ufimtseva@oracle.com
References: <87a4uvw066.fsf@pond.sub.org>
 <CAMxuvaxzwfYoguEijwHs4N5_iF8s8FLs853vse+mMaQA0ckQAQ@mail.gmail.com>
 <87zf2us2c1.fsf@pond.sub.org>
Content-Language: en-US
From: Jagannathan Raman <jag.raman@oracle.com>
In-Reply-To: <87zf2us2c1.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH1PEPF000132E6.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::26) To PH3PPF1D715CB68.namprd10.prod.outlook.com
 (2603:10b6:518:1::78d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF1D715CB68:EE_|MW4PR10MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f43983e-c828-4620-8c3d-08dea153f69d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: mjGqthON7l1XM7U9w7SPNcCnehrDxKS8BsWOhvpc6b0Z3dDA29dQnV/+taIEeyit88z2tvUX6LIiYaQ92jeNVpKL7H1b9F/LeSLrJdBVtqnVHgnGqfcNpRKpjSAfAgr369HRxO0yA92dZbQZofQ3fEDR3/6LNuXL47hERromroHHzgZwgEQWVzGcJ3jlrai9O6gaKT1gp7VldDgSkPsfPtSvfnbXGO+JQZEMV9x66KdtcVRcusEQlTorxQWmpjyucolc7B6D1KYKSS3BO9XMiEByTrguu8Bnzq69gp7TqxpTvEq42kBkinsYASM5f2m9OyLMJ2ttF1z1pDzfxlINnYNrIaj6pQS5nm6n1irtIKQBUWjJBxP/L45vOa4PMG2PdMU1hUW/+W719QStsEo4+ORMBmdHvzEPI4j4guqK1SBrcwy+uI3O7k1hBXKE0bre9Ai73SH4+qtgZ5G5SEnup8l5ubMP9deZj10judca46fB3TpU+cZZ52DFk2BqWN7yEZ8ColDHujQKyncn/ugoyGICj+aG1nltX0ICOAIIWrB06gbHoRK80oMLz4Zc44FMlruTdv7WA61u9PC/FE6hxKk4pSw/HvzuST2wWsCTXldVspK5WoNdsVK+Jc6I2n5d4K5l4oWGdJn6Ma2S5s7UFKyi0LG/YPfiEP0ob9GJxteuUb78C0e3YOl0P3djzIXVAW9PoJ5j/YO4b+Zhm2fwGjvoNVseN6Ke4yAtvzGClPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF1D715CB68.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjVHR2d1RFpqM3FuVUs4RkhLVkxOWUZYdURZTmJ6dThob3hzVmRFbnV6NjZq?=
 =?utf-8?B?b1hhRi9EOXlMT0xFSVhHQ0VlQW52dW9POFFvWHN6SlZiMWJ3MEtWNTRjdnk0?=
 =?utf-8?B?N2ZtNWRJV2xxUDRwL1dwZG5FUmQrL0JZV0JzNkpjcTdWOEtDemNvb0NqSEZN?=
 =?utf-8?B?L0paY0Fkb2RsYkFLdzBGL0ZyQTh2UnJBVFhWTUhtUjRGN3ZmQWM4akpaUGY2?=
 =?utf-8?B?NStERUF2VmpFd2Y4b1I5cVVSWFJDazU3U09ESkxaRWhvUFVPaFBPUDFYSEdu?=
 =?utf-8?B?b2k3S1A2c1VUbU9ZQURmN1psVmN5SFYrM0F4ZWlrN29tWTMrMjRHcUdpTE56?=
 =?utf-8?B?cDZwb1ZkaWI1aVkxT21VU1VHekduTG44cW1oNUhQNjVFNWRuNmtkREVwd0Q0?=
 =?utf-8?B?UnBsNkJ5SXJvWlBxUnc2UGdrbTFOSDQ5c2hlbFBqVGJWcU5xTUJtK0V3NmRM?=
 =?utf-8?B?MGlsK2pQREhycG5vc3N2VlR3clFMc1FwNlVIMTAxVFkwZDE4cEVmbVRNNE9J?=
 =?utf-8?B?MGFBVzZEcTdpTHpMaVdkY2VUVjc4T2I4RzVVR09BT3dkOSt5bTMvRldJL2RJ?=
 =?utf-8?B?aEoxQ29RRVRqWm5UVFY3dnkrVEdqRUJ1dFRaSDR4NHV0dGtxZkJIbkZnckxS?=
 =?utf-8?B?Q2g3dXBtWnBYaGJ0L0VnaG5GRWFRby9QSkFqY3FFTENGWklNdzlUdnI5RnNk?=
 =?utf-8?B?ckhYV0xQTEI5ME9pSmNVWTF5bDVhT2JHZ1hVQi9ZQ1ZCaW9aTEVhdGl1djJ2?=
 =?utf-8?B?SUxLNVphd3NKdVBuWjBlaVYyT3ZlT3JLbjdRWjRYdUNvZ24xbkRrZHk0a1M5?=
 =?utf-8?B?ZjVGeVN1MFEyVEVDWlQrRWhneVM4dVJ4ZFlITXBtUHdxVjR2Uk52WE9Cckgv?=
 =?utf-8?B?RTFUZk00bVpXNlRXOEo1MVkrSGpFUmg2TTJxb1I5a1JFOFdXY2ViL2RRRklO?=
 =?utf-8?B?QXlRQld2V0tGTHhPV1JMSFk3bHozNWdPeWRFdEhVRkI3L2JqR0Fqbm42S2ZX?=
 =?utf-8?B?U3pXQzJNd0ZqcG1ZY1VDNll1bDhUd3dRaGZZdzY0a3pNdW15a1dqTFAzcEd0?=
 =?utf-8?B?dGtqNmZjYUJnbjcwMXVLMjFrbW13TCtMc3pCSS8wOHJKQ0dLejUyeHRqejRx?=
 =?utf-8?B?Vis0Vk9BRWMvT2s2TnJhMFRHT1UvblZNamVrdTZIUFZNOUtpeDRYOWx1MEh5?=
 =?utf-8?B?aTh1VHRobVBXU3VIZkJMOFRWUnlBa21HdnF1T0JPUWRpeFlsSG1VVk5XRC92?=
 =?utf-8?B?UWpOWmRQWDNyNDFqai85akRwdGtzWUNXY2xtbFBXL05QVThJVkZDN3dCNll2?=
 =?utf-8?B?YWdLdFRvaVNBQmFNTWd1Rml6VEJCcUJmdFkwNVJVUHBXSWxodDJzSHlZTG1t?=
 =?utf-8?B?SFRpR1Y4TmN6YUxFVUF4dTF6ditZZE8vV0ZsQUxESnVyYW1mTWFyaS9jMHFO?=
 =?utf-8?B?VFQ0eE84bWhPRVMzdTBqQytKR3k0My9YMEtEcXlQdWlLZUtRNkI5MU1WZVVQ?=
 =?utf-8?B?WjNmV1A3Y09CbG1Sb0MyTS9WYkpkNkdFaWdFbWRreDVHYXBNWEVjblhTeEUv?=
 =?utf-8?B?SG0wSEJBd0Z1UXV5c0MwSzZQeEFxU1dsMWFpYnJqaUlEZEhNTTI5U2FSSzlT?=
 =?utf-8?B?ZE9COVpHVi9FdlVSZ0k1bzhrcXhTeXA4WFcwYlh3dXpLeC9DQzE2Q1dFMWhJ?=
 =?utf-8?B?ZXhCdHRqYTN0c21udkRQNm5FdUkvdzQrNUluOHpwZFhPak1tVmYrVkJCaGdX?=
 =?utf-8?B?cENCSC9GSHdwNjVicnZONHFBMFkvSm15TDdZc29FUHVvZ2hMc3NiTm1BR0Ru?=
 =?utf-8?B?SStUS0ZSNWZYeEp2QVhjeGlzank2SWoydW84YWJIZXhNUnBXWUxuQ3BCQ1hq?=
 =?utf-8?B?ZG5BNXNGcGwxMW9DY1pxZnJkQkFrekpzVEJWWThKelNzVDdicnM2VjJ1RGVt?=
 =?utf-8?B?bllXZisycklDQ1U3Zjg3UjJJM3o4bHNXbktlQnFyZjQ4RXFiTkRzTXB3SWlD?=
 =?utf-8?B?c1JPQjJBdys0eE1zSGVHTmIzam4wbFNOSGowRzFodjVoZTBNc1lqQWZwalc5?=
 =?utf-8?B?eUxiYXZZMGJ5YksvZmJLaExDdnpML28vYTE0akVxSnNDYkE1OWhUYkhVaW0x?=
 =?utf-8?B?RHlBci8xM1FnL1o4RXBINjd3M3p5YmxTNkx3eGd2OUw4ZlMwYzdlM0p1MUhT?=
 =?utf-8?B?UWorc29LdENURk1vM1IzT3JGWWFEaDFaOEN2MzA2OXkya3hNTE1wSWc0OUwz?=
 =?utf-8?B?emtvczBVQjRUbDJSMnNFVXNlbFBZQXBvZHQ2ZlgrMkd5dm04cFhUYit0V1kr?=
 =?utf-8?B?RzhYOFJnelJ0NU9WQ2pvM291QzltNy9ydVZ2N1FRQUdMUTRNdHdkdz09?=
X-Exchange-RoutingPolicyChecked: rLzoRcrWN8M3NS9Rm61ZuDoG7Pqc8+JJuE9yrThIwkzmIx3gFMrhtGK/ieLIfzr8ED1fSz0lytVKyeYFf96YaY/eaRi/XMKZijx+en0wBsaVUEWM6NAHl2lpPKWrzLlJfTS7YcTvSCEGNy++7C4Cbg+2tqGLVV/8jpO8ShdT/9Usc6Z1HcPHo0NtN9x0x6krML1EFiy+jwH0wB63HsROgSZF0kLiiFagIBDTil7Xb4V7cEGMyXB4DnRFDvEuVbxg91i7N1I6Sk5pY72j5NcJb6ViTPwSQi87Oj6WZxRNsRgKsGv3eidI9rhmnsT5A3XmhVWUmj8loSM2qw90vVDKPw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I7mBSZeA1btV9TX4P05T3YREqphB1ifXgLi+6guDAQpsg9hG11z5xLE/ghKynxUfvM2ajFfAHMldCI7XaPIKPOakIflMsKJZdj8D7ngHsgHCStgZJJK4kvCty/ONXGVac4SFExqWyFQFyml5xCY7PV6P3CNDsqYf2dTe/SB2xBR32zMoj8dTlV176dRt9V2px+vB1JCCZxJamAPBv32fX0qdfZ58YNfZDjOmgx9lZWsH4l4CJTN1FCj/8bVdei8hARVDDJ+3ZI2JKrzUh52joOlIwL/yLwCOkH9srRmiNke6mlEuYs6/TEqWelW+9Dt2s1WU1TX6VHL2L+W2ysobBTJkU3gh98uysdL+Qu9lF840zn9+cqsMXJiFanWXqtMPN6ZZcxQOhGHdozZMrZtor0/a3pGhmkA5RO/gk8ghZAdbGyRLYdr0UvEhYRZPfH33rf5/IDpeUQLDgwtqSMfl0wMLWfFK8ogwWrcjKWmDGhXmfKN174on2RkdkLv/QqUL3U67vrdn1jfBbVwyerOLwT3tfmnDVMI1rgclKVxwGea7jLA3G9u11XnFAw/e3FQib+YnTvDLUDg6iRgBncFP/jUvMGjT7z/t4uTrdRdRRoo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f43983e-c828-4620-8c3d-08dea153f69d
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF1D715CB68.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 16:18:32.6886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3LNTmt4RuQEWa625bQ7SNWBQeOKYlMbIqK9AmpNYrn6ftacoIj8LL1a8vLqw3TxvoSLtz7cAdCvUb+LmvPFsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2604230160
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE2MSBTYWx0ZWRfX57ULVX/5nKf3
 uyqQCBkkWso9B8Ts3djHpMzkueilYv34D/zKtyMfy7UnF1IaJ87jY1fWqWAtzfThxMq/XDM3kL6
 wHuPnCj8CLgaqMhYlZiqqVDSP3rqzJyg8xmzJq8iDAgn2K0y3vTPTfqXRGAybmGiiauRfBt2z/u
 /Xu6TPzhgYbhItXMKMpt0dN7Yd0laSXMgLl5wBehRUr3xLIP6JhPlAxPut36ofz9QPOPOlYs0rj
 nueDjbEThdCMdQmFBx9LOYr7KlmaQ0p0TgxnwwuZGwz5R4q3eS+ulhmUHp1l0ygmzV1cTx13645
 qnGnWLee8kp3aLDkd9Usk1STgpOy/DOI2L+GHo+kGKzMqcbTO8r+2d9zaWbs/B6lhKRg35ATvM2
 Bnbsz7M4zoI5grARqzqpMnAAmq3UVndXcVFSatgJtijVhA77Glp57zl23m9DfQ02xC0ipRglZgq
 zfKsAcOMiHaWfGoZGvQ==
X-Proofpoint-GUID: uDIWgq-NQxBfA-UjYZC9Ai9Xg_g6NHGR
X-Proofpoint-ORIG-GUID: uDIWgq-NQxBfA-UjYZC9Ai9Xg_g6NHGR
X-Authority-Analysis: v=2.4 cv=JeKMa0KV c=1 sm=1 tr=0 ts=69ea465f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=20KFwNOVAAAA:8
 a=_BfJ7RLkRjq1j4qx0-kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 4/23/26 12:55 AM, Markus Armbruster wrote:
> Marc-André Lureau <marcandre.lureau@redhat.com> writes:
>
>> Hi
>>
>> On Wed, Apr 22, 2026 at 6:16 PM Markus Armbruster <armbru@redhat.com> wrote:
>>> QMP command qom-list-properties crashes for the following object types:
>>>
>>>      colo-compare
>>>      cryptodev-backend-lkcf
>>>      memory-region-portio-list
>>>      qemu-fixed-text-console
>>>      qemu-graphic-console
>>>      qio-net-listener
>>>      x-remote-object
>>>
>>> Testing gap: tests/qtest/device-introspect-test.c guards against such
>>> bugs in devices, but not non-device objects.
>> Good catch, are you going to send a test for it?
> I should; I wrote device-introspect-test.c.  I'll see what I can do.
>
>> fwiw, I found also a critical in "filter-rewriter": (export
>> G_DEBUG=fatal_criticals)
> Reproduced.  Seems to be the only one.
>
> Thanks!
>
> [...]
>
Thanks for reporting the issue, Markus!

I was able to reproduce the it for "x-remote-object". Could you please 
confirm if you're working on a fix or if you'd like me to take a look?

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x0000555555f6f2b0 in device_listener_unregister 
(listener=0x5555589893d0) at ../hw/core/qdev.c:208
208         QTAILQ_REMOVE(&device_listeners, listener, link);
Missing separate debuginfos, use: dnf debuginfo-install 
boost-iostreams-1.75.0-10.el9.x86_64 boost-thread-1.75.0-10.el9.x86_64 
bzip2-libs-1.0.8-10.el9_5.x86_64 cryptsetup-libs-2.7.2-3.el9_6.1.x86_64 
cyrus-sasl-lib-2.1.27-21.el9.x86_64 
device-mapper-libs-1.02.202-6.el9.x86_64 
elfutils-libelf-0.192-6.el9_6.x86_64 4
(gdb) bt
#0  0x0000555555f6f2b0 in device_listener_unregister 
(listener=0x5555589893d0) at ../hw/core/qdev.c:208
#1  0x000055555595a7f1 in remote_object_finalize (obj=0x555558989370) at 
../hw/remote/remote-obj.c:157
#2  0x0000555555f7582e in object_deinit (obj=0x555558989370, 
type=0x5555577eb700) at ../qom/object.c:715
#3  0x0000555555f758a8 in object_finalize (data=0x555558989370) at 
../qom/object.c:729
#4  0x0000555555f76b43 in object_unref (objptr=0x555558989370) at 
../qom/object.c:1232
#5  0x00005555560c9287 in qmp_qom_list_properties 
(typename=0x5555580e0430 "x-remote-object", errp=0x7fffffffd668) at 
../qom/qom-qmp-cmds.c:282
#6  0x000055555615edae in qmp_marshal_qom_list_properties 
(args=0x7fffe0006250, ret=0x7fffebb75da8, errp=0x7fffebb75da0) at 
qapi/qapi-commands-qom.c:326
#7  0x000055555619a81d in do_qmp_dispatch_bh (opaque=0x7fffebb75e40) at 
../qapi/qmp-dispatch.c:128
#8  0x00005555561cb1cc in aio_bh_call (bh=0x555558609210) at 
../util/async.c:173
#9  0x00005555561cb31a in aio_bh_poll (ctx=0x55555784eaa0) at 
../util/async.c:220
#10 0x00005555561a86ce in aio_dispatch (ctx=0x55555784eaa0) at 
../util/aio-posix.c:390
#11 0x00005555561cb82e in aio_ctx_dispatch (source=0x55555784eaa0, 
callback=0x0, user_data=0x0) at ../util/async.c:365
#12 0x00007ffff787cf4f in g_main_context_dispatch () at 
/lib64/libglib-2.0.so.0
#13 0x00005555561cd334 in glib_pollfds_poll () at ../util/main-loop.c:290
#14 0x00005555561cd3c2 in os_host_main_loop_wait (timeout=0) at 
../util/main-loop.c:313
#15 0x00005555561cd4f1 in main_loop_wait (nonblocking=0) at 
../util/main-loop.c:592
#16 0x0000555555cec0f1 in qemu_main_loop () at ../system/runstate.c:948
#17 0x00005555560df5bd in qemu_default_main (opaque=0x0) at 
../system/main.c:50
#18 0x00005555560df677 in main (argc=15, argv=0x7fffffffdad8) at 
../system/main.c:93

(gdb) p device_listeners
$3 = {tqh_first = 0x0, tqh_circ = {tql_next = 0x0, tql_prev = 0x0}}

(gdb) p *listener
$4 = {realize = 0x0, unrealize = 0x0, hide_device = 0x0, link = 
{tqe_next = 0x0, tqe_circ = {tql_next = 0x0, tql_prev = 0x0}}}

Thank you,

Jag


