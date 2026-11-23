Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC0D606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=laGGRLya;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DJVTAP9p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVYDH-0000lN-PK; Mon, 23 Nov 2026 12:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVYDG-0000kI-21
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:52:22 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVYDE-0002yL-HX
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:52:21 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGGqPE846515
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qQP/OxISsPO40Zu2eZI1djU4UreCOxAum+lxEfFfDXE=; b=laGGRLyawLts8Y4u
 TCsi57/IaP36ApZlLVQd0AlKsJyc+gq1eDbea7FEOk6x4lguIfvq+wkLJOcpoa7B
 MghCmfvxOREH7g/Mn7srsxkZM5a+pvFuV7DA5a4rl+D+vix0AIDTivJYfYD2S6e9
 1yDNXKqsH+OX+jSWwVPo0j2bGJGOerDlusXgTZlRVj8DAisDyoVKMoy/TX+gQeXv
 +35dmLIDlE9HaxP2/AUEDKESrcFE28sPgrmukx3D8PY39IRDt5ZNFMBplMx/Iu76
 nG1lXmc/PFG1EG11E5wmNpffkMUqoRx1U2T8lkRrLWd667fKGIJSZ586nYOADWf9
 S6GDxg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g742pab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:52:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3b167bc8e16so2860210a91.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 09:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795456338; x=1796061138; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qQP/OxISsPO40Zu2eZI1djU4UreCOxAum+lxEfFfDXE=;
 b=DJVTAP9prqrmkjqbbLfRw/Tu4rS6ysEem26UiwG5xlb7JRLYysg5VH+DIewbYmEbJO
 L2XY+qpvihliAjNY6nU5H4NnpHuzPXUmFsixMvC0iAA+T6SV0shZLHQETzWQL3ZQMWNp
 2ROOtL7DhgHJvJRCIa688pcpBPksY/a+fVVcBMk5Gc5KD+gPH6UKRHmKD0m4eBohtUhK
 U+jnSTSYFaTpSOmTOc/XFzVtjQb0HENF+W202pOy8EluXEakpEYrdVMkUODVp8qTTDYw
 ATe6KNw9fis5gR3wM0Ekki9+vpKuG3g8bIs/fvXTqi1Ban2dj0eeqJKUllVsh7nsNMpD
 WlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795456338; x=1796061138;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qQP/OxISsPO40Zu2eZI1djU4UreCOxAum+lxEfFfDXE=;
 b=Lf8CWM14WUKoOPeLlJ2HhGu3KqEvEWf8RTL8E6JTRjdtQ2c7N8USd1xMq6ub5ENsys
 BYsC5tMbDulF9qePjIn/GeZ0NsqFj9R8zMEftYdCI8t5EbpEV0oro+8eglJDh46ucFRq
 Au9yBpBbVPCdmJMLcB4JMlVpB/z61oudKRfXh/HdOvhbGTn+g58jILV3rpFwGlbAbbbL
 Rz71/+PWm6glJq+Xi/aYDooIs5/0FsgknCMv0j1l6whpsnlYZ6SU6riFt6a3CWEtGq/0
 EvZ69I5nQOoqmkbTAjkubdfVJhACCXbLT6D8iVdn+tPb1IEQOvKOqA1a5pADRlhQU2MT
 bRHg==
X-Forwarded-Encrypted: i=1;
 AL+hErHmSNRxIybkOKdUX2+gnm5LXomDfvncXOhFQEIFlg4JMK1NxVX9wpJ1M3sUSTcnbEPFfX4hkKRsLVpI@nongnu.org
X-Gm-Message-State: APuU4Z9bmpv/9fpLvE96IrYffcTANyrIFH2xLEQEhPCdGDX2Nxq1Nxu5
 VYVmAIRT8o8YpmdpwHIAPDRLnUQt8g7+VWDjoSac/T8A+VbzB4QPnuLWp2e+weNmfB7ofsa1aPo
 HQUZa6s5vK3IyaY/kfASUablQIWLD31hTkPVxD89JieUpENPfBgn1tcFf/A==
X-Gm-Gg: AZFdTZdu2fRrGIw5qARgs2DhROHUSjOckLDpbCYP6YDrFVdZ/7v/ozsEgJCBphqraC9
 WLIAmu7AoUWHGF+xI2VkkGQ22Dbm5k2NWsyVlGOwD1QsleNfEjkreAo1BbYwWSgFUY/N8sLf2OR
 1anlrxCG18KUF6YBCBlxkaZ3Eg7khu8ZSWnPuYiv9898BRmWmwM9dDXtrggOIcHi6qfc8N7BBdN
 8qP9rWEaWjFYnN8MjC7AwB9FM3yyLkpFGLa65dm+gA2t+bEsMg48E2vEHXUS4FwLeWsXx1qhOJR
 AimKr97urbIGNdgZqGv5UElVhKst4kqogIdDw4wCMZ1hgBN5h4omW4CnjE0/jeofv+9EPWtNhvy
 uktA5Di/NGDG5yd0LLEtdLGsQj8GN3PF9e1S6ysf1JB084dixOmvCtg3mFAIJTEUUwVaTkw/V2j
 Drnol9dBSvOYU49N4SztNIC2otyCY9BzUZltuttggfFDs=
X-Received: by 2002:a17:90b:2e47:b0:3b4:eb3:a34e with SMTP id
 98e67ed59e1d1-3b41c8fe15emr10412161a91.21.1795456338071; 
 Mon, 23 Nov 2026 09:52:18 -0800 (PST)
X-Received: by 2002:a17:90b:2e47:b0:3b4:eb3:a34e with SMTP id
 98e67ed59e1d1-3b41c8fe15emr10412146a91.21.1795456337581; 
 Mon, 23 Nov 2026 09:52:17 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41ad0a34asm18681986a91.3.2026.11.23.09.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 09:52:17 -0800 (PST)
Message-ID: <1adbd5b1-71a2-43a0-a6f2-2dee8a59c75e@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 09:52:16 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 v2 04/12] target/hexagon: deliver floating point
 exceptions after the packet
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
 <20261120182031.560481-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261120182031.560481-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MMcyXkr1cYozy1GNjWi5hXWt5Nf2v5Un
X-Proofpoint-ORIG-GUID: MMcyXkr1cYozy1GNjWi5hXWt5Nf2v5Un
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MSBTYWx0ZWRfX+IXXB+ortH9q
 ZDArDO7in663Ges7WuyLpxiRpv9r71PrM8k+7jnnbpgQ44rAy7BFJhc7iFYOzcgT3MQueiA9nks
 GLmK84/NMC9t4JbD9uS4mrQUqMF1VyY=
X-Authority-Analysis: v=2.4 cv=T/cZ3PKQ c=1 sm=1 tr=0 ts=6b047d53 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=aeLbRA1U7RjvwJyXdLQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MSBTYWx0ZWRfX2HvmPqVvKSQG
 3LN6Vft53yCbg0YsAlaQrK6MPvOD6C7JSKP8ST5lHRPN8Ij+Q2lHGioDyjyXZ2hut0SrA87boRi
 0zxRSTAwMJQXEpxjFhvL21WItwYJGdfasQuc6EASoJTXk4bl61eHB6DcWZLSPRbgXvXWwxHfEgG
 we/DRLClm1Nk/Tixg7th6maiNbc498jHYwxs34/k1XQUKa+Hj4+JyE8RN2HmcdsP1FzbVM8PU2h
 3Lxs9bVTmR5yQtEia6U27TzG5ZGMtXrxwrbE84ohiIlwE3ow+oqYVHJG7HUp2lMq9IfQsMfve+0
 KLtYFdKBLRYH0z28XqheTowFW016P/IXv8lM2rCQocH+x++873pGTJTmsEKFOmZsdJn/1oDLE3b
 /M34bd1cD1A943lRL1TdkpMtWME7F8UaDzcGriAQo0Ood2v4B8/ngcWUuJGOsex/fhT2XJhp2o4
 J+OoGA59rsRLpd/Ow0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/2026 10:20 AM, Brian Cain wrote:
> An unmasked floating point exception used to take the exception in the
> middle of the packet, with whatever PC was last written.  The
> architecture takes it after the packet commits, like trap0, so pend it
> the way the TLB pends an imprecise exception and raise it at the end of
> the packet.  Report ELR as the last word of the packet so that a handler
> resumes at the next packet by advancing ELR by one word.
> 
> This enables the float_excp systest.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/arch.c                     |  9 +++++----
>  target/hexagon/hexswi.c                   |  1 +
>  target/hexagon/translate.c                | 10 ++++++++--
>  tests/functional/hexagon/test_systests.py |  5 +++++
>  4 files changed, 19 insertions(+), 6 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

