Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2D7C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 14:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukOOm-0005xB-3j; Fri, 08 Aug 2025 10:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ukOOX-0004pc-E9
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 10:48:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ukOOU-0006Up-RZ
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 10:48:33 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578DNa1k007151;
 Fri, 8 Aug 2025 14:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=aZ0QUnVuKlunx12+Sp9uNq6GG7z6a97bnPnoyKjH6Nk=; b=
 ZGhEsgri/yLcTrcpx09d7wIAg9HhujwCww/A9pT8fWuRNXLhrKvqEQvlQ8WxphE0
 sY2GVdZbvjliatXI6QrCLowc6arycYE+rOn7fsqxbU+yRRdBWIIFS0/3cDvfSthh
 gY6ArBI01VVho/CVzMH5Flm5+T1Z0fRDw3zfOnEe/ctku/zLVimfiYIIRh7LKK4I
 z2cuLkF7r3cTJ0t+HnG0Kr+mOqJ9A9Fq6Wa9vGJgIseuYhEtgrGMK0rGjIOXTwqW
 5pDuuEA8CH8kn2aFRttVUr7mTPnMaazw4Ds4vYrEeQ57tdvZ3bUpauJbPBhTWGaB
 UX+srXGHkehHJaruWhgbfg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvg6fdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Aug 2025 14:48:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 578EcfNg009764; Fri, 8 Aug 2025 14:48:27 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48bpwpu2pn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Aug 2025 14:48:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lb8yZrvqeihFgCClQ8BdDK6A72BgizOzzB9Abi+tPdozYQgWh3wgLegfD67qfOmnYKzuwDilBI1Z350XjN8wDqMDW3tp3BxBDcCbY7rl3eAJx2T5LyHG0bO19Vo71B7LkUSqdvcpoxeWB1YMaH/Py+4lkhW5E0e7zn2kZOcha7pBmVUbLsr/dwAlduPz37hsRrAeWtMID/J6ryaGCmoBkKqI3gMaFbtBexvIQ9cm8MfaHaJPhuisOjfvd96vOdbIcbDsclH5YjEEpJoZRmisIHjbH+b0SopUGV4SOlFBA6BZXa3oaTKu5XIS2BJ6eK0LLp20qdIh9zTECQgOrNjBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZ0QUnVuKlunx12+Sp9uNq6GG7z6a97bnPnoyKjH6Nk=;
 b=nVb7+bDZhty9oJ41r/1heAU08ROYlxU/O6Vj/l0RxqwPGyvowwTlGsLNw66GVSUWoh9GJ6Qof+TzTsBaV/XORAmTwoZ1l3dct8KrFqHW2la96dL3oZ1kS02TMJZDsiT6LnPSo37GtHd49oC7k7sBFnArvoZwmFMYyqNoJ4GYdoh4+HU2GIsEXpEnz+/wVh08nieT0PrfL6fU/6WFQeqLRxi5zApG7r+fZHcZiG+XmoT9G2eDXsoXykrz+w9HlO5TcUbOyAMOsCkn8HhaAbTTeF7cmndzKMn+9QVGf25ZuuHLTgwQM3W1ZpylWVGCb8srK+7ebQZ1x6wcvOmsJNNKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ0QUnVuKlunx12+Sp9uNq6GG7z6a97bnPnoyKjH6Nk=;
 b=C1SaIImkSCRC0P/G2wBAqS/nK4SuvuQ4zUJ8ATSMdzeRgDfos+OC/fmSs9KvgoGP5bbO/B+2KJYfeBIPAKV7XY8nG35hcF4jGZ0PWps5wvv1gPq1I9tyGAUjblMk3T5O5K7tiN2ioSgjHjsZmNJgEbo7TNWbZ/FbcIKRXfkgFAo=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB5968.namprd10.prod.outlook.com (2603:10b6:8:aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 14:48:13 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9009.016; Fri, 8 Aug 2025
 14:48:13 +0000
Message-ID: <045c76ae-684e-4920-8d25-74cd3afd87e6@oracle.com>
Date: Fri, 8 Aug 2025 10:48:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] migration/cpr: Clean up error reporting in
 cpr_resave_fd()
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-5-armbru@redhat.com>
 <6d876750-9d7b-4556-a1e5-06f7c7487eb0@linaro.org>
 <aee57c51-b7e5-4c11-b8bd-222251c4ce91@oracle.com>
 <87a549dgc6.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87a549dgc6.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH2PEPF00003856.namprd17.prod.outlook.com
 (2603:10b6:518:1::78) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b22f0a-9181-4c26-a9a4-08ddd68a9a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3orK1ZQRjJEem56TW1IbGlJMWMxRVFkNnFRZ1Jpc0o0ZkRndFpFSmkycVVJ?=
 =?utf-8?B?SncrSlNNQ2JHQnFEcFVsZjBZTFU4UURnZVZDK21NSC9KOGhxYmk5eFZEN04z?=
 =?utf-8?B?U2NFSWV1SEp0NjhnK3pneDFSbFpSYnhmeDk2SWJRaDFmUkhMeHhSMXZJZFQy?=
 =?utf-8?B?WjJORmFybGJUWVY0M0sxK0hCZnpYM29ybWhTV3Q3VmYrb0g2eW1TSjJMRnRU?=
 =?utf-8?B?ZExUR2ZBN2dvRHlEQmRwcTZmYUFXYkNOMnBXMnEzcCt5V1pXbHF2WnBORHl3?=
 =?utf-8?B?eTFXeUFMSVE3dW4vMXAyaU5UTS85QXZLZk5hdDNybG1nN3IrUUVKSGxqc04x?=
 =?utf-8?B?a1RVVEllaHJsVytadDFrQjY4U3N2eDFjZ2YwRllBQzVGT1EzQXNDUVJ3RExX?=
 =?utf-8?B?YnNpUGd6SUU0V0xTNExISXkvZkthdWk2OEZydy80V0QyNTRjbmFua1dYd3R2?=
 =?utf-8?B?YnJJME9lRm1OTkVnelBBd3ZDbVM2M1ZjakNHNFpreWJPMHBRdFdjNGdtK1dq?=
 =?utf-8?B?YnpNNE5MeStOb2ptT1FmNzUwSWFSck1ZWFdncldkM09aTFltNGp5a0dDa3Mx?=
 =?utf-8?B?NVhNSVNpTnYwK1RyYW1sOGo1YjJwMDJCSXFlSEYvbkxXQk5oZ3djMm5xMnZU?=
 =?utf-8?B?QjUxOXdySnFTQjl5b3M2UjdUa2xhYzRLQ2pDSkJTWTk2eG1LTEJMTUpVc05o?=
 =?utf-8?B?cWcwbTlzMVUwU3Nma0xkeU0wUDNtRlA0TXN5c3lLNHh1M0VjOVlJd0RsY0dY?=
 =?utf-8?B?WnQyR1ZrK0ZkT1pqRkNtN3g0MlBPZnM3VkttSmUrblNiRXlSU242WFAyOTFF?=
 =?utf-8?B?T2ZVYjNHajUyNm1IWDRLK3hLTTFSRU5HR1M1UlQwUzh5ZXI2Ym9nbjJ3bWtv?=
 =?utf-8?B?NFJ0bmQwdEpUMjh6UUN4OGhSQlh0cWRHb1FKdHdvVlYwK2gzQ3RLTU1VL2M3?=
 =?utf-8?B?Snpic1AvV2gzR1B2TWZ4ekc3Tkc4UWVrWWExR2M0Z3FXOGo3bWMwR0xKd21I?=
 =?utf-8?B?dTFLTWZxcUFzM2o5Z1Ntc2pmcXl0TDdrbDhSTHF6blUrVTdMVE5VREgzdXZE?=
 =?utf-8?B?ajkvQURvaFBFaW1kUCtTeGZsdnpQTE9EWTF3TlhQbTJnMXhWa3AxbFoyV1Bn?=
 =?utf-8?B?eG02N0o1RkRTV0d5MDNQNXd2Uk1oWDhpemNxeFVxVVBjcUU3enRTMllvZzNJ?=
 =?utf-8?B?ckNRZDZuVEh3c2dwY0xhc1lJZ25RbytwSWhBbk9wYlQ5eUVaeU9Ub2JJK3RX?=
 =?utf-8?B?cllGcnIrd2tUbHg4WlRGbElJMkZoekxLc2ZGZWJBSTNhKzhKV2xJTjIrUENn?=
 =?utf-8?B?M05ZWFUrcjZ1Z0VTMFA3c2hhb0xndGhDMmdWalhHcS9DMGFiVkUwVGRWdHF3?=
 =?utf-8?B?VXY4Vnl4SUdvNm1kZ1VzV0tSSGFaa29VOXFZUWZLWjRTVVlvSUdhL2tSVjZ6?=
 =?utf-8?B?am81cXd2anA5OHFWVEpyZGpnSm1yMkJHR0RvZ0EzOVJsWFVyS01yWGdpeUZ0?=
 =?utf-8?B?OHltcUtpWVFJOHBkNjVxb3hzSGNpZ3k0eHFmNEYvdm81dEZPa0crdDV6M2Rx?=
 =?utf-8?B?WlJoYjhIcWlQUzdtQzlGMzEwTittNWNWSVdDalhLUitUb0pWU2VmKzdGZEMr?=
 =?utf-8?B?MmFDcUlLMnRoV1hBRTdEQWJMQlQ2NlNGOXBiMHRoSUNha3dWMWhRRm5lK2NI?=
 =?utf-8?B?RU82MnVPNmpSWTlZQ0laTUVFNDJUZzlJVVZFYTk5cHFUK1Bmc01tM0lhVVd0?=
 =?utf-8?B?bndZZ0dKL3NLYTJPcEpmWHk5REtIbHo1K0RQeHRIZGNSWXNlNk5FMGpMM0Zj?=
 =?utf-8?B?a29wTEVEZ2VVUEttZjR3c2JQTUtTUkU2QXRBRDRPb29FMHl1Sk5sNTBUazlS?=
 =?utf-8?B?STdKL0F4ejY1UnZUWjhtb3M1VXNmZUk3cG5pVHRVQWRacW03S3VZaHovbytR?=
 =?utf-8?Q?pSHImBpvhGo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWxGZ0dFanlXZ0pkMzRoNC8vQWYvdFFDUExsUTR6OWFTb1liTHJBeDY0Umps?=
 =?utf-8?B?YVFqT1IxVmRjWUdCUTR5MERzQkhULzUyWGdUYVRaU0h0eWt1LzFOWFhzc21l?=
 =?utf-8?B?WDZnUXU5V3ppREJ3ckxGb3JVcks2ZWs3VFdZTVhvejRtUnE4VjI5MjFUMDE1?=
 =?utf-8?B?MTdpTjg0S3JFMWJveng1akpwNDFzZmhxekZEQm1URHRXU3Vuc3Z4TnhJcFp6?=
 =?utf-8?B?MjFoVEloQTdaRW43SW12VTdsTkxMY2liNmowVW44eTBHSDc2YWZ4dVNqc0J2?=
 =?utf-8?B?MTlmR0Y2KzBXWWdQWmFHdDJlUVhXMndUaW1rR3RJUkV2Q1NGb2RzSXcrZngw?=
 =?utf-8?B?aUhPL1JDRlMrM3VValhpSFNWdzFMc0tWVVFjajhaYlIxd3hPSmZrWTB3YjB6?=
 =?utf-8?B?cTBKanpBMjVOTHdpOXFEK093czJEWVEzZ29pWEFmQXdPQ0ZsbDhmQmVWd1d2?=
 =?utf-8?B?UWJtSGJ5VDRjMVhBYlk5cmtsNUxneThacFZUZlZTYldudVJoT0pkSnpWUWty?=
 =?utf-8?B?d21qKzlXTmU5VnhZQngxa0FiMjhhMGM0RnVabDRRUFVoMDdoQld1ZVlJN1p5?=
 =?utf-8?B?ei95S2JSSFZFZDNiVkVId1ZFUTIrVGh4WitQcUxHYkM3MHVNdzJwM3dhbjZH?=
 =?utf-8?B?VnB6L2xoT2RBQ2tJVDRUeGQ5dFVqR1pBNk53NVYxNjFMSWUvaEhMYWU2UzRJ?=
 =?utf-8?B?QmNWcjMyZ0xyL2o1Yy9pdGtaMlNoZ1ZwZVJTaTBpSU1SdS9OMEhsZGl4TTdl?=
 =?utf-8?B?WnRaR2pNUzRxWHFQNWRHRFdWM1M0UE9ka01jSDRPNy9YdlRHMWdFZHZlQjFF?=
 =?utf-8?B?RnhNTTgxNUlCSXhWMEZWNVY3Y2J0N1ZIUE91Y1lLakd6N1ZrbHdMcmJJTU1B?=
 =?utf-8?B?eHRNTTBNVDVsQ3YwK3NDMmxpRWpVNm9Sb1NsYWsvV0RheGFZZ2ZuZURaS2xq?=
 =?utf-8?B?ck8ybVZKRG9Nc0VUSWxjUnFrelV5akhXejk3dFJYajBlOGRMZTY4a0lqZzZZ?=
 =?utf-8?B?akRxZlR3eXd2Uk9UaXlzRnRTR281bHVoMnFacktwbE15UkFyL3c5M0hIVk1h?=
 =?utf-8?B?WXJuZ3hTYnRPOUprMWJYaUxTaVQ0eXI0MjNBN2tPTU1IOTY3OWFwWnZqZ2x0?=
 =?utf-8?B?OUFNSG5nUFlmRXFNSENKSktDSzJacTQzVVAzckl2aHl1QWZ5c1JCZ0tyNXNv?=
 =?utf-8?B?WVhObkxWRGVEQzFxckFNWC81QTdLQ21nMTMxTmVianVRTlFGbFNhbldERmUw?=
 =?utf-8?B?M0FuYmlKVU0wWG9VOEpnNHZia0R6bWc3Rk9LT1lNMlkxZlg4a3BBN05YUEU4?=
 =?utf-8?B?eU03MmpVcVRUR25GS1dReVNtQlVyMFF4UVBsSCtQNTFpdzkvSm1KYUN3ekJl?=
 =?utf-8?B?WU9xdE8xWnRVTFZVd1BpZ2VuTlRkZUdMdDE1UGtPd2hyUTgvWmJVNHYyMHo2?=
 =?utf-8?B?Nlp3TnpMRHRpT0krSEJiWlRYbm9NZjNKVkh3NVpPUkNheTRYODBUWGt2ZFlM?=
 =?utf-8?B?RDROanhtNW13QXhZNmYyT3FFTHRyQ1ZsMkhPdEZEOFdHUjdLVGU2YzdzeFNi?=
 =?utf-8?B?eG5ubzlVY1RSaW41Mm51L2pqeDl3cnFGNG9CdDNBRXRSeU1KZk14aHg1UG9W?=
 =?utf-8?B?bEx4andpQkE3REVVS2FlVUlGTjF1K2dYbzdIeStZUTBYNkNnZzRta1dHN3RY?=
 =?utf-8?B?Q3FzaDNYNTRLM0VTWXZ2cmNkYnAyS0NVZTArQWgwQ0VaUC91UVMzS1VGYmpJ?=
 =?utf-8?B?Uk1xWENQYnN2bGdWRVBOSnlSRG5HcUp1MjZua1l0c2p1Z2lFaS9SUnUzcG50?=
 =?utf-8?B?cE12WEJLQ0xBYkhxZURvZnJFM0hYMGZnZVViUXdRQ2NrRk5CZ3lIajZ3WlJW?=
 =?utf-8?B?bmJEYTFmZE5JVUl2K1Z0OUZ4Ujhha3FpSHpOS3hyaU9MV080MHkrMjhFTTcz?=
 =?utf-8?B?RkRaS1c4SVVqbGtaZ1k2V2I4cDc3Zmc3Y0I0WUJkVW9lazlhY1QxaDhtMXZs?=
 =?utf-8?B?L3JIdzdja3EyR2psWW5uaWlHSmpDTVBGNW9ja1N4SVlDaXAydHpQNXovOThR?=
 =?utf-8?B?SDdJUnA5cUo3OEdWTmhMaW1nMTMxOEJCblovalFhdGc0cTNHMGpkMU5qZm9V?=
 =?utf-8?B?WGlHYWo1Tm5wYXk2ZmZXeVgzcW5sSkQvWktRNEU0UFhsc2hMckh0TW9YSE9v?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ROZa3SZfgTd4brL80Y1XZseCdTC3R4eLEw7cMfLquEO8Hh0/6rrM54YKozBuaJrIBn9DEYYcvJ1wO82BBn07sS328yMF7YCC09a7Srk4ADyunutvCYzU8WRWAbRZGSrlnv6SBXsnU7WFY41Eii8UjSTgDCJbknJhNInpkqxWUKXDpoWqHoVU28A8kYMpCJElim8hOPc5NoXfw3IOEXZhpoCuA9n5+EB5beqYt5Bhry24duk56fMALotm8yBFvGq18A8jDnqlvj/ErokIzGF9J/fsC3d0PtVxkT4Uhl5CnY1PmNS5X1lre3ngIgSwkpbLgDIeCcg0Wm9m5Bmnn7JQ+WzrbaSRU181oM3Cw9UryvY/evknIePXkaZoNLfoiha5URC8ieYPZMtrmlXuz7gfMMUjw53Avo7dacWBMrNJgDrwcXyfOkIrs0wKPhONP1gzclTninr+WvZsAEsFJxv82tZB4Uvh8BtL0g51S6CeypO7hmxVo3F+ybspv6Gin/tycCZmlMYXTS0iWyO38JsIWeTEye5rx+LVkOgDSwBzBdSO4yw16xIcqYCjfDjZwxjzhoHgxTMsI7cU9Cqyh2uQDezcoDt64D9CslSmsPIODZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b22f0a-9181-4c26-a9a4-08ddd68a9a0f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 14:48:13.6711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glnv3er9ZVFym26KO3T2pvtimHTeoxGlNACYGhV1lHes1F/FN78LBCDjpSZQum/eJ0mcLQSJl4Z4MRN9/SOFJN1tO4i4eYavF5EI+E05KtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5968
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080120
X-Proofpoint-ORIG-GUID: imo4Y3u0Nc_SlHF_76x0xbTJPWG0C1i0
X-Proofpoint-GUID: imo4Y3u0Nc_SlHF_76x0xbTJPWG0C1i0
X-Authority-Analysis: v=2.4 cv=QORoRhLL c=1 sm=1 tr=0 ts=68960e3b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=KvwUX22yvS-9wfdV7gQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyMCBTYWx0ZWRfX8JT7PuCPFovb
 ulmWLLX+jVcBl1QWTGcZu4k68gR2+1EvRfTbhh/JCwuBLyUU0yZaj8p/rJxOV6YlrDYJxKwaVBM
 ehYsrNHq/fzjZOPpBgV0OIhxZggb1+24aGp9BMTsIKexXIhmRCYlEBFSdX16T1FSGeqg5P59ZsU
 U+McWmW31NnRAuu4r7z0AqH3MeQ0vs8f+N1FvgxwHjuq4l2xTaTbuiE2XI2HSxCPWw+9IcE44nY
 XdgdCHzClgtsbk5fVBKGU6cD/dgFPG6Eg02NgCbCc/2BAijWvIOqOdk4p7fTLEysPikFkwaWq/S
 AEELkY1TYa3sjykokmnnYJcvkcEvNmGuEd0EmrChRCiKaWdXQKm3hUCPuzVh8xLS/BRMiJeCEwk
 L4S0Y8fv3ScPNlYreAzTWtGNsMY+GAvYixvnoQ0UgDZ0debAXzNiA/ziAsfphQYv2VoMqYb3
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 8/8/2025 10:43 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 8/8/2025 9:55 AM, Philippe Mathieu-Daudé wrote:
>>> On 8/8/25 10:08, Markus Armbruster wrote:
>>>> qapi/error.h advises:
>>>>
>>>>   * Please don't error_setg(&error_fatal, ...), use error_report() and
>>>>   * exit(), because that's more obvious.
>>>>
>>>> Do that.
>>>>
>>>> The error message starts with "internal error: ", so maybe this should
>>>> assert() instead.
>>>>
>>>> Cc: Steve Sistare <steven.sistare@oracle.com>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>   migration/cpr.c | 9 +++++----
>>>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/migration/cpr.c b/migration/cpr.c
>>>> index 42ad0b0d50..908bcf83b2 100644
>>>> --- a/migration/cpr.c
>>>> +++ b/migration/cpr.c
>>>> @@ -7,6 +7,7 @@
>>>>   
>>>>   #include "qemu/osdep.h"
>>>>   #include "qapi/error.h"
>>>> +#include "qemu/error-report.h"
>>>>   #include "hw/vfio/vfio-device.h"
>>>>   #include "migration/cpr.h"
>>>>   #include "migration/misc.h"
>>>> @@ -100,10 +101,10 @@ void cpr_resave_fd(const char *name, int id, int fd)
>>>>       if (old_fd < 0) {
>>>>           cpr_save_fd(name, id, fd);
>>>>       } else if (old_fd != fd) {
>>>> -        error_setg(&error_fatal,
>>>> -                   "internal error: cpr fd '%s' id %d value %d "
>>>> -                   "already saved with a different value %d",
>>>> -                   name, id, fd, old_fd);
>>>> +        error_report("internal error: cpr fd '%s' id %d value %d "
>>>> +                     "already saved with a different value %d",
>>>> +                     name, id, fd, old_fd);
>>>> +        exit(1);
>>>
>>> My 2 cents, I'm not sure this information is more helpful than a plain
>>> assertion (at least for users). No objection for this change.
>>
>> The message gives more information.  It has helped me debug
>> problems in the past, in concert with enabling cpr traces.
> 
> Is it a programming error?

Yes.

> If no, then "internal error: " is wrong.
> 
> If yes, then exit(1) is wrong.  I'd use assert() myself, but you're the
> maintainer here, and if you want this message rather than the one
> assert() gives you for free, we just replace exit(1) by abort() or
> assert(0) or, if we're feeling particularly fancy
> g_assert_not_reached().

I would like the full message.
I have no preference on how to exit.

- Steve


