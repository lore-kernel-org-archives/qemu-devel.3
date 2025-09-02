Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA199CA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIIM-0001JB-Mo; Tue, 02 Sep 2025 00:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utII2-0000mZ-5z
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:06:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIHz-0007JN-81
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:06:37 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SYRF025749
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eNei/JOJiSmqB5zjEDPmpm0XgwbqmPG1n2k0peYzAtA=; b=Hnq2ERzN63yvDiRc
 j974Y0GLMjQdF0ceydn1F9rOjsMsJZ1VrptxjdOrxNEdXucdnU38DrtA/OPifHE/
 Ctihq755iGSic/h0EPp8PEYyrfbsfrw3H5TlR20dIOuHsAylKlU3hWkmHrB5EoKV
 W6+c0RMzeEcIAgEh+y1ZxV4O4FfEhd7fdWntgj9CmfCYqdT7cmTim3IbubAWeAH3
 80M0U2zrQpIBBl4ELwXWK2NH4MVa/Nsgca6rVlytneWcKkOGbYGlvdFQ39aCCfid
 Q0hlZxlxFFjPbhUcCbZfZi1y0WEMY8xpQufPSo0hf0EReTBqiMxfkf3ou9J6cNwv
 F0Youg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuxfhf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:06:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-248fbfc35ddso71819925ad.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785992; x=1757390792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eNei/JOJiSmqB5zjEDPmpm0XgwbqmPG1n2k0peYzAtA=;
 b=xEOCgC4YB2I3LwnkGxt9tMuu3u4lemmOXpGz6lBpxH90CHtsBrC8DMif+e8uoYMg7K
 JpKJnu/e81Z5J1dOZut5PDtuHcLWzIY5owYyOU3IvozZxLXTP/BQbndVC8+/3Y+sbPN/
 dNBGG0t/sc4j0/+VZFOQ0m3uPTO9qtrDeNVu+ABHIxhX0eVXKjRkpmIV5Z/l/hVpZRIz
 DqyApkwrh7nhoB14GHJXuqARulGV2QKiKTcezHo5oliLDP2E0oWY9CF2k5KswtJZxGhL
 yU4iGd92MZqtELgUZ3cRk4DToKLxfS+VRehze6WhUA2Z8bNI0RQ8x+go5/Z2EVADRutC
 lfgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQCT3Cxg25QImupV+Zgzy4J8QnwJuP2Cm12Kxqh3z3g2bcFxazUJ0uaitCNNnqrHfKVrXfaMyeKQKk@nongnu.org
X-Gm-Message-State: AOJu0Yx7BcXEajQeiZMbkCwqa5hqOw3pqyfhp14Y5HloAzhbpEHdPrEj
 YV7BH0fYrhmt1KO4RtrVk61G4mIFHlxS2jTaq3E2uhHo2s0wwoSDXKDK0c/6Bh7WCWTCmPUHrJw
 WmNyho4aEBenK2W6xtAYZMBrwkFnAD+mIr0hEK1kQxAUqsw7EPZ1wN4/PyQ==
X-Gm-Gg: ASbGncui1vA+oz5VV8qtBl5vNTonYl0zvkWS0EtWDdRjVCZSCNUqXecwkz9H0mxRLis
 dh+qLj9LkEbC+q6L0DFq5dfX4w8w7VaQD5+PD/dtV5E0cblFjuvJ6XIesTzKU/8ac70GpSatiEO
 gc1kmZAV/G4o39tQEXF6S8X38miQvjQQp5UpSqdYcAIzE57aLOXcK1LW+Jpqyfjduzf7iPXfcYU
 T2cPU5R2zdsVuweE8w/g+SbGnzm7X/WY/RTRw4Tc/9V6oyIqZWIiutVeSCcLjRw1ASzN423puxN
 bqL0kOdkrMw/infzodFZ2KCNssbMBCrVUUSnPvPxMIm9xMr1aoKRdcJ0sprrJA==
X-Received: by 2002:a17:902:e552:b0:24a:f79e:e5eb with SMTP id
 d9443c01a7336-24af79eeaa3mr43405575ad.49.1756785992195; 
 Mon, 01 Sep 2025 21:06:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa7d/f4qX/2jeO69pwcSuiF/kcxjVQeT+Ewj/vmwhjI3RyzEKX9KAvbXSSf6K+lg+7lTvhWA==
X-Received: by 2002:a17:902:e552:b0:24a:f79e:e5eb with SMTP id
 d9443c01a7336-24af79eeaa3mr43405225ad.49.1756785991763; 
 Mon, 01 Sep 2025 21:06:31 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903727e23sm119538555ad.45.2025.09.01.21.06.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:06:31 -0700 (PDT)
Message-ID: <f15dba1d-db0b-4ecf-ac8e-dacc5464f1c6@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 20:39:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/39] target/hexagon: Implement modify SSR
To: Richard Henderson <richard.henderson@linaro.org>, ltaylorsimpson@gmail.com,
 'Sid Manning' <sidneym@quicinc.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, "'Matheus Bernardino (QUIC)'"
 <quic_mathbern@quicinc.com>, ale@rev.ng,
 anjo@rev.ng, "'Marco Liebel (QUIC)'" <quic_mliebel@quicinc.com>,
 alex.bennee@linaro.org, "'Mark Burton (QUIC)'" <quic_mburton@quicinc.com>,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-6-brian.cain@oss.qualcomm.com>
 <017101db9763$41ae4ca0$c50ae5e0$@gmail.com>
 <IA0PR02MB94862E1C5171AC300C64DA1CBEDE2@IA0PR02MB9486.namprd02.prod.outlook.com>
 <026201db9839$f4bb6040$de3220c0$@gmail.com>
 <2712e0cb-72a3-4c39-82a4-4b5f6d4914b0@oss.qualcomm.com>
 <02ae01db98ed$6d15add0$47410970$@gmail.com>
 <64531a80-822a-4d90-8731-0e632e7f8da7@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <64531a80-822a-4d90-8731-0e632e7f8da7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX+rYXXCxSU7/J
 D1TcpHjcLFSJWEJG6/yIsObH1CzP4fyeWXb6ORlv+NTZ0Wtd6zT5c2ub/oSEPLZbT7tw8fEkl5L
 oGSir1UAR1k8tQiQMdKWxLXoZOi1/6efEtOwfIUMS9cNw5jIQ8CEqcI9ExYQX2fsyzh2gjpz3KT
 krC2mwY5LHLFf2YxuWa+oPU7cncxYGKox8tQyISXRAcweemgj2WEjV89pqcX6ADSFSYc/lVOsXj
 bHf6FicjBq60uXf+AzhMBboybrfQjsjKPESTGhY9B6GvvVzY3WC+63J2b6GG52KKE+NyJ9BgVs/
 Qy0zxbpWtQnc/envppOaf2ILHvuYXmc+GARieYSWoYyQU1GMF10Mf8Qqu8retCkM8l5VaxMmhz+
 0aOC9wLt
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b66d49 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=3fVDdpWRf7t-k99dPRkA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: r8Cn2lgfINtosxHRwMMINF5ay4lH4TDA
X-Proofpoint-GUID: r8Cn2lgfINtosxHRwMMINF5ay4lH4TDA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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


On 3/19/2025 11:58 AM, Richard Henderson wrote:
> On 3/19/25 09:39, ltaylorsimpson@gmail.com wrote:
>> I caution against putting a level of indirection into CPUHexagonState 
>> for the HVX registers.  The HVX TCG implementation relies on an 
>> offset from the start of CPUHexagonState to identify the operands.  
>> This would be a very significant rewrite if it's even possible.  I 
>> don't know if TCG's gvec code generation can handle random pointers 
>> or a level of indirection.
>
>
> Not yet, it can't, no.
>
> I've been extending it for random pointers because of Arm FEAT_SME2, 
> wherein we have indirect addressing of matrix slices. So we wind up 
> with a pointer like
>
>   &env->zarray + (env->xregs[reg] + offset) % size
>
>
>> If the behavior is undefined, we can avoid the copies.  Then we just 
>> need some bookkeeping to check if multiple threads try to claim the 
>> same context (if that behavior is defined).  If copies are needed, we 
>> could keep the  hardware contexts as shared a shared resource.  
>> Another alternative would be to track the current owner of a context 
>> and copy from the previous owner's {VQ}Regs to the new owners {VQ}Regs.
>
> Depending on how you answer these questions, I could split out the TCG 
> work.
> But in the short term, copying context data might well be easier.
>
I've removed HVX context management from this series and will propose it 
in a future one.  Indeed the behavior is undefined when multiple 
hardware threads try to access the same context.  If the TCG changes for 
indirection show up at some point (or have already shown up) that would 
be great for us to take advantage of.  But the copies seem adequate for now.


>
> r~

