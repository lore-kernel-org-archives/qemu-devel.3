Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9524C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWbwi-0005YD-Jo; Tue, 01 Jul 2025 10:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWbwf-0005XQ-RI
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:26:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWbwc-0002AO-Hq
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:26:48 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9DCR028043;
 Tue, 1 Jul 2025 14:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=w84hXILvys3/I5pDs85G9Uq3hujrkQbb6rPnsgXKH90=; b=
 bD9ON94VYEiVcNH7MRHPzNF/TE1c6Eqg2Qg8vgo6DRwx5FcQbJHP/g2be6SXbUnO
 aSkH/sFSvBXnz2NrtKt7OmtAvDo8qonTp1ZvzIPnQjgJhLb+UPeZCvSIDVjcb4u4
 GGm6QSYDlwjbI5BBIwGMmMSU00A4NSThSyjuvfCJYSu2chN+1v+5YSiiN1R0sLl6
 AhxlYOgdVvcg6rAgR0VjEXryDXeKTRKNT0kO+XEX6F4YvtTNqmZ7MoXXQu7BdJJa
 JOc+ZgkPwDNRnIiN//XD1j+Y2ndzVUGRSpjaQSJge3FOiamrkXDx6E+r4343sSNq
 xkNwMiE0boA037QLLHa4oQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766cwdy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 14:26:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 561DWGbN019238; Tue, 1 Jul 2025 14:26:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47jy1ekpch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 14:26:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPSt+swBI7xvEDkt85VGpQU7/nUuhgQV/BpdR+NXle7c1fc8XEIomx8D76yibxuL8aKc09sqs+XWT0BZ5bDbM5NA37fAD58ba6P3iTmtP5eH+CfXuEkT7pgQWtZH2Xb+E1ixYdqZ3vDrSYgnXeIi6mNFVOibNrNQjXplgw6EWsE+NG0Ww7mrMbMBCpeJTn3VYguABs46GT8s1pcnvEtd0ePt9b04XQ+9wqZvyxQtfA8sTjZGAl4cNMBsUVTBztD9uaGPHMqHyxVNXFZQ+RaLEaNrQN7ZWGd/HuI09L3aWqaGthkU4z71Q5I/r4mOxQ/UwCU1J2B38oI8bbayVdTAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w84hXILvys3/I5pDs85G9Uq3hujrkQbb6rPnsgXKH90=;
 b=WVvv/b2NAAVyw+5mX9MI4qkbcX4GjuYk7PD/ie0FQ4AkFDioWBhrN5jPwSdcGgWP76hZBVp5KxZac9dgEM+d6xzT4iRlrJGBX4ch98Xb2i7GOQ1PkikEmNwrPDifDfPj5kxM1bmE+8O+KA88ssDccXjZRXssHe52OvTdUvpOhSXOzGZoQbUaaiK0423jGVqYy1W9fAJq5GKG7AEWBRMrsADo6eqnHPphKlU9F8lVErsgnM+na4YWFA887P7n13xNYv8ryJGMOX3mqiwZi3m0yeI21ZGt8nAbBqRW3ROtnrE/fO+mNhlqteaiBt6ha7VurIHQoVbMbksd2HG40//VNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w84hXILvys3/I5pDs85G9Uq3hujrkQbb6rPnsgXKH90=;
 b=Ad+ary40pSQPgl6bLLUxx2HLRSYLzpbDoaVhZrFjxbU0r42x8ZjC6tuNQiP5utu601Itw8HqQ2omu7rd8dmujZhXDwvj24N6bUg0It96QnNSmXrh+Dvyp0jBv+cCnplrpxJebV9c2U7BTTTpA8a0om0GLiSvD3VbLPnWaFD0/5E=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7088.namprd10.prod.outlook.com (2603:10b6:510:268::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 1 Jul
 2025 14:26:40 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 14:26:40 +0000
Message-ID: <735fa30f-e5f9-4777-8765-7b1436e26a35@oracle.com>
Date: Tue, 1 Jul 2025 10:26:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 30/38] migration: vfio cpr state hook
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-31-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB9136990A7C183E88A5E3A9909278A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB9136990A7C183E88A5E3A9909278A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0052.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 751a7027-ef94-48dd-4cc6-08ddb8ab4b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTI4YXpLK0ppSmJvdmpFbnF2MlFOMDhYVkxXRkdZbWVWZmUxeUMvTkN4d1cw?=
 =?utf-8?B?ZFplZzlhSjk2QnE5cjRDWVExdzJkVllZbURWVHNzdjhXOWtJL2x1TGdmN2E5?=
 =?utf-8?B?bGU1NXljSlNwN1JnMUNRVEpNSTUwVmo0elNYeTNzZzZ2THd5b1N3dXpod3VU?=
 =?utf-8?B?ajRlYWJkTUR6bzBYR2ZQYVQvTGtnNTVEOUxCcTVCSkREeU80U0dzczE0bzNZ?=
 =?utf-8?B?WUlrWmg5ZGVyN3doTjc5ODN5Q0p4OHNwN2dYSEpHOGJaYys3YXp3cElYUldP?=
 =?utf-8?B?SDV3N3plN0xjREtsK1Vic3dSYmY3bThJb04vL1JXT3NXdm4vVXIwNkZCM0NG?=
 =?utf-8?B?STBrZHRtTW8vZWZHcGFidS83N1E1bzJHSk4vYkRRTjJ2ZHlmYkpqb2hmcmVi?=
 =?utf-8?B?QVVnSTlvQjFFUVE0bThlRjJ4RHd4NEE5dW50NVFCbnNoZWdNTzkvOFZ0dEZB?=
 =?utf-8?B?aFdXbXlmbVhTTW5WZzE2Z3VzVGlJa3RSZS96V0piVEFLMHo4TlRsSkNzR0R3?=
 =?utf-8?B?QmFSS2VISXBpd0ZYTkpNbmk4RzZ4YkN5Zmc1SzlaZUo4REd0TVhTMEZ2SVU2?=
 =?utf-8?B?ZHBudFNXN1dDTUtCU0dhZHNLR2pBOTFIRFFuTGIrOUhMSDdrdEg3eWVJT282?=
 =?utf-8?B?YWZWcitTMXhlak05VjVKbkZMVlNUdGNpWTYzRVJCMGlMRTVPTFF5bDZMMkxx?=
 =?utf-8?B?Tnp1L0VQUEpQN3l3WU1RdFdrTzBWZ3d0Z2lxNTNTaFhvdjQrbklNWHFsOGQy?=
 =?utf-8?B?TlpZZ29LY0VPa0FpSUQ5d2lLUlFVcjFEMC9GNkxtdjlwVnM4dXVuSSt4Q0p4?=
 =?utf-8?B?bG1hQ3dYd09YR05mVHg2NDJ6RklrazFaWmM4MnZDMWtrYUg5QXpFQWFOdUxt?=
 =?utf-8?B?U0I5enJzdzdjeFlDSUdxMmQ2MEJIcnVPZTBVZVIyajhOWSsyQ1JmQkdMTmVP?=
 =?utf-8?B?MnJ1V0F4M1ZwZDc2U1NYTjk5MC8zTzJBRGg5akFPaUorUGI5R29XVTNuMXhP?=
 =?utf-8?B?TVlWamZRWHhldWtlbHRJNWlUakNUa2JWbUFtNGFJcGlKbzlpaTZ5Qm52a2JT?=
 =?utf-8?B?dGdCQ0dyKyt2ckF6eVgxemk5djZsbFp5V3JGR3EydFAwamUzWVF0WkpWNDVE?=
 =?utf-8?B?b29XcEFmZjMyUXo3bm9YVE4za3dCWE51RUNNSThFeDNIRFZHOVY3NGVuRC9x?=
 =?utf-8?B?M2pTRHFrZ2JXM2h2L2xZcWx6azAweEtoai9NMXhUSEdCdWU2aWR4SENvcGdy?=
 =?utf-8?B?NWhWZlBHVkdlbnBYck0vRmtVbnRIWDY0anhKOFJSMy9Cb0QrK1d3dDZtOVpD?=
 =?utf-8?B?ZnFGTXBCc285WnJDRCsrSGt4RFY4Y01PZ243Y0UvV1FJQXcxUENScyttaWho?=
 =?utf-8?B?WTlQMXkrdkplZURocEo0RXZnQ2tsWnJIa1hlVkNMbHUwZmdzYnF3MmZ6OEZn?=
 =?utf-8?B?dlJPem1qa0p5WVFDem1TMGxXTGdoMjRHdWJ6WDIzQVNTNFhMcXZTQlZ6cmlX?=
 =?utf-8?B?a00zY3RNSTlqNnRNck1zeElqaVU2b21GbitLQkhCVGJINTJrUGVoNW1XL2h0?=
 =?utf-8?B?Nld6NkZLVldSL1dYTTliSFhiR251aldxMUJDSjZlZjBRa1BUbnl3ekhhcVJO?=
 =?utf-8?B?bnZQSmx0eG8vU1JtRjZvOGV5TXk3cTVWM3A0T3VOK1VSdi9SK2k1RUFhN3Fs?=
 =?utf-8?B?OEh5TjhIQXVudElVd2dLc0dJZ0dlVUo4KzdzUFd5QTNJcElOZkE4MEF2QmxL?=
 =?utf-8?B?WGZMZysxVHFCelBnNTNISTVkODAxQkZvWFBHR2t0ME82Y2ZFWUkxR2d2dGZO?=
 =?utf-8?B?TnlGeFNtVlNMeWduelE5ZHR0c3c0N2dXNTFib1BqNVJFUzVsaTFsUVgrV1ow?=
 =?utf-8?B?bGQyMDd0ZHpFUzc5TXdWdjdCKzRzWGdiU1pNeTNkRjY2SXhSOW1zUkprT2dS?=
 =?utf-8?Q?q9xeIUKOYO0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjFRMTI1b0hadDZYNy9VbkF0eDRUWDhIcFhmaTBGdHlLRE4wSENPMkJ4c3BP?=
 =?utf-8?B?QktSb1dERGtPak1Sb0tEdnZ4NDBxb1FIY3RjaW9Xa2ZXcll6VWY0aTZwTlBJ?=
 =?utf-8?B?TUx4Z2VXc1JVd2hJTVpLTmFtMzBXZG40SkhzZ0o5bm5tNEFJK0VJczlrYkhp?=
 =?utf-8?B?TW1ST29LaW1Gay9KSnFkTWxHQlVERzFJaGs5SVI0U25ZcEhNTy93VVAxWnlq?=
 =?utf-8?B?WlhHZGhtUm51VDhlSm1FbXVCRVNIbHVPYWNTL3ljYlJCblBOWFRUZnFSNkND?=
 =?utf-8?B?bnNFcDE1K2pSWHI5cEVPRjQ2OCs1QThROGsrTUd6Z0hDSDNsRFg4MVBKMUEz?=
 =?utf-8?B?MmZ2N2VUeWkyVGxBY1lySmdNTGdlcjNieTVWRWRESjN3clFTUlQ0Umc1NFlZ?=
 =?utf-8?B?cWpuSVlUR2VTbFJMZWFrWlljN2ZvQWxRd2ZmSjRSdnd0RmVSOGdMVHg0bU8x?=
 =?utf-8?B?cVJSOE1TbU1sMC83eENMMi81QXZlS1Y0WW9RdS9XcXE0VEFBa2FWWmZUd1FL?=
 =?utf-8?B?U3VMUEV5S2JLbS81TFpuWnZqMjBRUHk2TXJwUUxWRmlTTXFibVk5Y3d2U0Yy?=
 =?utf-8?B?d3RFeTRhNlp2QStsOUdYRlVQUDUrNTlmOTgyTHc5b3FBZ3NmR05oT0R5MzlP?=
 =?utf-8?B?bE5Ya2RnY3JGdHBiaURnMWNuZnlzMVE5Z1FGV2pKUkF6WUFqLzBXdjlHbGh4?=
 =?utf-8?B?T1Y0MHdMWGFGN3dnNGtSOTZiWk0vMDF2L01SRUl5K0JNejUzODFwZk85K1I3?=
 =?utf-8?B?aHBDVnZZbENnVnNVZ0Z6bFM1cGEzYVl3NkFhYnFxeHJLQlRBenJkVG9UYVJu?=
 =?utf-8?B?RlkzR2VWL0tFdjgvcG4veGFiOWx5YTk5Y21tWE9Rc3RmSW9zMmVlRng2eGJH?=
 =?utf-8?B?NlVDSFZvL1Y4Q3J6bHVlUW5SK3V6dmVrTloyNmcwTWdvUThvcmVhVm11aGJP?=
 =?utf-8?B?R0F4UHRMSTRHREtuVVpLMk1OMVcycG1mcEZVQzlsZEVRQzVLK3hmM0ovR2Mr?=
 =?utf-8?B?SndRVFFia3kzcnRVdGdjVmgrUjJCbHNaYkNIQ1lKWGNaQVRZOTNQOXJsUHlj?=
 =?utf-8?B?VmtDcTF3T3JpN2RYRXpUaGJycDlJMVFiNUVpWmZ5VFBiR2hhQWdCeGxEZ2hw?=
 =?utf-8?B?emZJSkRTYmkxWEl1UitRNmJDMnBISXRBVGVWMENCNGRYZkZIWGY2K0taWVFN?=
 =?utf-8?B?ajI1YlRqUlJ6dWNTNmVvOVZWT01DUXluNjRoRXNTUjBWbjBtdzJBWko0Ky9l?=
 =?utf-8?B?UFNXYTBZSkFrRkVzYVcwOHJXN08zYklmaWVRaTlPY01KVFJSaGFmU3VDLzBt?=
 =?utf-8?B?ZmNxRE4rS0d2VlUrVjQxNFNpWjkxUW1IamlDUnBCa3JFZGViajFwREhpeGxh?=
 =?utf-8?B?Y2kxQUhuZmhCYlQ1bUVHN3p4MDQ2Vlh5WW4wN0dyb2xBYnd3bXp0enFTWGh2?=
 =?utf-8?B?N2lQZUhBQ0IxWlFRNXArN2ZMamtQbFRIU0d0RGdyWExyUTI5ZnlxTUpiU29Q?=
 =?utf-8?B?eTY1WGF6TlYxbTNhdnlOUWsreVBwYkNYMUloQzhDYXlPYnl1Nk1DblI1U1dz?=
 =?utf-8?B?bHk3UUU0SlFMYnVJaTNGWjZEZXhsZU5ISXZ1UHFYVVdRczVMUHNtb3lacVpZ?=
 =?utf-8?B?aDRHMkRkTVkxZ0RvZjNRUThGOGFPcG9Pam4yRGJzMnk4VVkxZHhNMUlleFFP?=
 =?utf-8?B?VFFvQXRWZG9IMW1xbUxFSjZSbjhVcHJSMjNBMkhEOUFXdUhDd2NFNC9PU1I4?=
 =?utf-8?B?YWdNNkhtUjRaYkRQM3ZzQ1JldG9paWhwcjJNZDcxNDhOVVFVRlpITWRVK0Rh?=
 =?utf-8?B?ODNHZzdyYkJPbEdpaElmWTI0N0lhQm1tQm1aaERodDMvZndTcUw4bjg3d2Nn?=
 =?utf-8?B?eUlCQWxSbVI2amNhdDZmY2x4bmtBTGRHVW52VDluUS9FY3ZMeTlZekZpYXpp?=
 =?utf-8?B?T016bjBNdVRjaFdjOSt2encrazZXWG4vVkhaenoxQ3JhemdCbmV3ZG9WK0E3?=
 =?utf-8?B?dGNJWThDdjBYM1pHc1VMTWlpL3R6TkdESW9Ddm9yanlHb1JObXh2T242aGEr?=
 =?utf-8?B?NlJ3RzVVNExsdDM4bjg5WXFmb0M3TDlzaG1GRUZ5UDRRelY3S0xmSHdQTWoy?=
 =?utf-8?B?NWFZNlBvV1FvOE1GckRpbUhoUXFtd2ZTcmNERWFnRmdOSWp4ajZrWk50bDFl?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tjs+H+3lpJwl0fGW8Q/KOUe+92Z0EUcbSFnMAzYc+tlBxsbfT0yXyEn2hGwbZ5u1/ajMReUustYBfiiI/Nx2fflh9WjHecuNCCA1KB+IZJGQ6fUdx8Kq94NBdGM6bwcmL5n98iECXsMoq0WFpUgqvf/NfwtDznXuJkrxjlhYTScrtR8svU8YFgs+QBDhhL1eQleLPBckBbchN0SznMQkOWk85cqgA/RnlE5GXVuUqrK1pc6Lhec20m3X9A+b04Iw+eqM8DiOePyZT6OWItgtg+WsswfRzKTD+wtMwNzgUAwsPSd9hWOI8HNo7qSr/257Rkp9n4+hCpNiy1Tj7i/dtYyBu8++MXE41EZON6juGC4fVlgcmTFRcR2KZ2tz5bRo1+cBqA5CuH6PBcprFsLxLla6WmpmjJojIj5qscji7gSGrRMNLi+Dgf256pQBHX7q2ZLb/hdNJCN2OS9OEfpz3Wez1UjfwvAZAUI7D5IfJ/OIpsjMDprL+HsDhqnyOPWFDrK+bKV9LKi9ATZ6Jb5ZGhkw2vW9n0QOcsyozG/cGwZD70V5d4wks5vwMXQ5veNkmFPvkoSaUnMqZxHYpJBcKUUvKYffuVVp68xcriBMpQA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751a7027-ef94-48dd-4cc6-08ddb8ab4b94
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:26:40.5317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhGL5qZmM5TNjogkvaEA78oeacq+2nUnrxtvr7+mku5/R0BF+stZtB6R2V9o+XqJ0ygpYAt5Y23YwYKS1wDyBLPGmpelB4UjJZqYeIFME4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010094
X-Proofpoint-GUID: -CS_fCDy2L44j4kzRknijAJNCb4dYdEq
X-Proofpoint-ORIG-GUID: -CS_fCDy2L44j4kzRknijAJNCb4dYdEq
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=6863f023 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=vbL2nV6ToTOJslh2OKAA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13216
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA5NSBTYWx0ZWRfX8Lth7zytdUGR
 OGeWcouZL9fD3Fhdn0SCtfOEaj/c0H8mJl+Dfnr55UU2sDTN+J/gDDvzJVskjEKp0VDUSPMhW8P
 7DmJFCBrT8H0oiUpJyF6a/Sj55FC7DUubTkw08CcS96UIiqf3/KJxZJB0nLA7FALZWgpWx8bjgh
 vnuOpqqvBRPaYjBpMCrb/XV44h/7kzwpcMcIaN551qex255sNf1jSn7Flt61mjQmP3xWZThnrD6
 jyWYAi8JCjKywawEJ+Mv1IFBHPBhmq9G++gYn7XOYCmebal+tsutTiLnRsETskFRzwhlvDXXosg
 8fNcDzVQZw9dAXLiJY6zEQN496RHHv1P2HYM4M8DjfzpAkaT9aFWM/JMar4F5yyT/x/rNYZ+P3e
 MopnOkXo53CKIGsfTdBOgsS4d9AeiQyuS5HwCKJf1BGLwlDqfBDqutEpLAVuPwxj7t7PcTgO
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

On 6/24/2025 7:24 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V5 30/38] migration: vfio cpr state hook
>>
>> Define a list of vfio devices in CPR state, in a subsection so that
>> older QEMU can be live updated to this version.  However, new QEMU
>> will not be live updateable to old QEMU.  This is acceptable because
>> CPR is not yet commonly used, and updates to older versions are unusual.
> 
> I'm not familiar with migration, may I ask how subsection help blocking migration
> from new to old QEMU?

Migrating new to old will fail with an error message saying the subsection is
not recognized.

>> The contents of each device object will be defined by the vfio subsystem
>> in a subsequent patch.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> include/hw/vfio/vfio-cpr.h |  1 +
>> include/migration/cpr.h    | 12 ++++++++++++
>> hw/vfio/cpr-iommufd.c      |  2 ++
>> hw/vfio/iommufd-stubs.c    | 18 ++++++++++++++++++
>> migration/cpr.c            | 14 +++++---------
>> hw/vfio/meson.build        |  1 +
>> 6 files changed, 39 insertions(+), 9 deletions(-)
>> create mode 100644 hw/vfio/iommufd-stubs.c
>>
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index b9b77ae..619af07 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -74,5 +74,6 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev,
>> const char *name,
>>                                 int nr);
>>
>> extern const VMStateDescription vfio_cpr_pci_vmstate;
>> +extern const VMStateDescription vmstate_cpr_vfio_devices;
>>
>> #endif /* HW_VFIO_VFIO_CPR_H */
>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> index 7fd8065..8fd8bfe 100644
>> --- a/include/migration/cpr.h
>> +++ b/include/migration/cpr.h
>> @@ -9,11 +9,23 @@
>> #define MIGRATION_CPR_H
>>
>> #include "qapi/qapi-types-migration.h"
>> +#include "qemu/queue.h"
>>
>> #define MIG_MODE_NONE           -1
>>
>> #define QEMU_CPR_FILE_MAGIC     0x51435052
>> #define QEMU_CPR_FILE_VERSION   0x00000001
>> +#define CPR_STATE "CprState"
>> +
>> +typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
>> +typedef QLIST_HEAD(CprVFIODeviceList, CprVFIODevice) CprVFIODeviceList;
>> +
>> +typedef struct CprState {
>> +    CprFdList fds;
>> +    CprVFIODeviceList vfio_devices;
>> +} CprState;
>> +
>> +extern CprState cpr_state;
>>
>> void cpr_save_fd(const char *name, int id, int fd);
>> void cpr_delete_fd(const char *name, int id);
>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>> index 60bd7e8..3e78265 100644
>> --- a/hw/vfio/cpr-iommufd.c
>> +++ b/hw/vfio/cpr-iommufd.c
>> @@ -14,6 +14,8 @@
>> #include "system/iommufd.h"
>> #include "vfio-iommufd.h"
>>
>> +const VMStateDescription vmstate_cpr_vfio_devices;  /* TBD in a later patch */
>> +
>> static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
>> {
>>      if (!iommufd_change_process_capable(be)) {
>> diff --git a/hw/vfio/iommufd-stubs.c b/hw/vfio/iommufd-stubs.c
>> new file mode 100644
>> index 0000000..0be5276
>> --- /dev/null
>> +++ b/hw/vfio/iommufd-stubs.c
>> @@ -0,0 +1,18 @@
>> +/*
>> + * Copyright (c) 2025 Oracle and/or its affiliates.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "migration/cpr.h"
>> +#include "migration/vmstate.h"
>> +
>> +const VMStateDescription vmstate_cpr_vfio_devices = {
>> +    .name = CPR_STATE "/vfio devices",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
> 
> Is there difference if version_id=minimum_version_id=0?

No.  Some developers add a new VMStateDescription starting at 0,
and some starting at 1.

- Steve

> Thanks
> Zhenzhong
> 
>> +    .fields = (const VMStateField[]){
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> index 4574608..47898ab 100644
>> --- a/migration/cpr.c
>> +++ b/migration/cpr.c
>> @@ -22,13 +22,7 @@
>>
>> /*****************************************************************
>> ********/
>> /* cpr state container for all information to be saved. */
>>
>> -typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
>> -
>> -typedef struct CprState {
>> -    CprFdList fds;
>> -} CprState;
>> -
>> -static CprState cpr_state;
>> +CprState cpr_state;
>>
>>
>> /*****************************************************************
>> ***********/
>>
>> @@ -129,8 +123,6 @@ int cpr_open_fd(const char *path, int flags, const char
>> *name, int id,
>> }
>>
>>
>> /*****************************************************************
>> ********/
>> -#define CPR_STATE "CprState"
>> -
>> static const VMStateDescription vmstate_cpr_state = {
>>      .name = CPR_STATE,
>>      .version_id = 1,
>> @@ -138,6 +130,10 @@ static const VMStateDescription vmstate_cpr_state = {
>>      .fields = (VMStateField[]) {
>>          VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
>>          VMSTATE_END_OF_LIST()
>> +    },
>> +    .subsections = (const VMStateDescription * const []) {
>> +        &vmstate_cpr_vfio_devices,
>> +        NULL
>>      }
>> };
>>
>> /*****************************************************************
>> ********/
>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>> index 56373e3..b9420cf 100644
>> --- a/hw/vfio/meson.build
>> +++ b/hw/vfio/meson.build
>> @@ -33,6 +33,7 @@ system_ss.add(when: ['CONFIG_VFIO',
>> 'CONFIG_IOMMUFD'], if_true: files(
>>    'iommufd.c',
>>    'cpr-iommufd.c',
>> ))
>> +system_ss.add(when: 'CONFIG_IOMMUFD', if_false: files('iommufd-stubs.c'))
>> system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>>    'display.c',
>> ))
>> --
>> 1.8.3.1
> 


