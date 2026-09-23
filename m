Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CA2C982EA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9JDl-0006Xy-U2; Wed, 23 Sep 2026 05:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9JDf-0006X3-WF
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 05:24:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9JDc-0002gq-Nn
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 05:24:50 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8Jf622197894
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 09:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zxs7SIVyUxCZkYHblDY95O8vQQco4NK25kUDU+Mkahg=; b=JnNIrEKulPNZYdAl
 /SbEcHADD0K6VEEVEFEz2aDhBzN2H2nEKHekZwu0YBpaBK43T/JERfYPOuN9iDeb
 UA+Rs5TCw1WhJvAXTcMk+Sd782MsgoIoN/Eo+a6sfASROv89DyQF5DtkrGfihXt5
 53HPaEKmFXedq4JidkBr3+yFl8Dx5qGN+YO2vpv/aMmPSBXzj+Gqms1Koi/eppMs
 rsP7QknKZa29F4o8Yo4pM3zsvCBgXFMq+yR+0y39SQttodoIAektFhT/sL6JSRq5
 56fQXb2VLnlMeTAmVz5Cku6AeNaNHtqNXNZDr5Yym4JWJBaa8YyRT5Ka3hzdeA9R
 BmDI8A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv9bqgsbw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 09:24:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934963b2bc0so161254385a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 02:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790155486; x=1790760286; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zxs7SIVyUxCZkYHblDY95O8vQQco4NK25kUDU+Mkahg=;
 b=awr/7+Wv2lcDAUs30M/NlVKO10QYWKy4+DZZffwlWjjdhtcnlmGrDG0O/BeP1rvru6
 a30xhjPnuoNietjWkXrbXCSuzLT5mwiFWySMq6hE65H8lk5N7wAU1YEGWRvWVawfp3sR
 K7ghwPuE5zyAy8JhKLMstRieLqqH4VRLiemOAQAtpPittfqZOUzQl1fOKHL/ViO++Otn
 jRLVm2++rKGWl2tNTuyhaUthrKc6hFngp1/kQ3pEStN692Q/q/M0TvKFs227IKR5SK88
 B1WlEcAbgNczgpMTOUM3YJa9SqkUgsPoJsY5SxYdGrATkmMjAx93nPodWTboCEiHzNO1
 5rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790155486; x=1790760286;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zxs7SIVyUxCZkYHblDY95O8vQQco4NK25kUDU+Mkahg=;
 b=OSvgJnvvgsmSnGsO3AkYSKTaOl9FXym4lTkGFeQGyaAzFilwraiOe5o2hDK4zjvJp8
 lLscch22U44gxMy/ZF3QLQ9Axm++Glb370BLvktPYqxdexERr2+oG1wBNuwf1usMxV2F
 YRzSttxy+0zaPGlSeE2TgP3+QtN1lIWi6Zigqj1/lcDNleIKCgaR6SiXbmyXXEvXOrFH
 JaPEnm94X8gmJ+CxY5N1U2UVTbfVmAlwPqsNdTCTMAYl4LcIDtc5EZNjtE+vlj0/+bmy
 pJ9LHd4KZvIDhMU8LzpYV2ySDKERlMU39bbqSXNem+4coeLnZKyly0zKjgHMV58XXaDs
 SWbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9HeyFolaTvMHWqO+6eI2dPA6cphlWINtLLQAV8y6Eqnn8HSmNCXcvh8M1GmWQ/DfzwIFPSwe3Nwuz@nongnu.org
X-Gm-Message-State: AFuF++n9g7JDI7xkPD8p1FZrDaDItOcxfPhHTxPXjDNi1/2FiRXZ0go1
 o5YFdGhkFVHjsaFpM76EQXR3jT/NBjhk7oEMYLE1/D9O4HsdAt4sSV0BOOQ6vTtRF+WwuYsKeRU
 SjRirowk4UjYtKw9c3msvB79Qgnyce3piOrIwuZXNj+jsxR9h3aGx4Xt04A==
X-Gm-Gg: AYBFou0ypUPwT9jEX5aotE3avxV/A90uBvNo1exKu7JD8lUZqQ9c08DSUXmM2lTuStc
 XjwklcQr+6b15+5+R4br/Zowqfv8Od+fZjF9UVrUy3CD3MQMiUTeImG8SP/Xav5yW2pHnIbp3Gy
 eaEBcRMf+ZxzTjfWbrpecaSFK1OKdMsTAaWlz4p7IE9t1Eu0Ts87H34vjiqHjONRqSUeRNDijUO
 XIPojyaEw5Hcv68fxEHuNzbKq9eqQFvAd8NMBPJf2+K6GQx208yb2qgBcgX5M4zq0ukhj9XVgNG
 Z4P04X6NWw9MdaDzVtzLryEX8KXr7Ufn9JmPCt8gHb3ppX0nfskwvSsO6VuXqDdXK76vZ8MId8w
 Rjb28CeEbMk3pHuK1RlJGLVHPjCJ0CsUJkZKC/BfujfugVD//zl6fzGoHbQ==
X-Received: by 2002:a05:620a:400f:b0:93b:c537:fdb8 with SMTP id
 af79cd13be357-93c25080eeemr300039285a.6.1790155485861; 
 Wed, 23 Sep 2026 02:24:45 -0700 (PDT)
X-Received: by 2002:a05:620a:400f:b0:93b:c537:fdb8 with SMTP id
 af79cd13be357-93c25080eeemr300036385a.6.1790155485486; 
 Wed, 23 Sep 2026 02:24:45 -0700 (PDT)
Received: from [10.21.17.122] (156.170.88.92.rev.sfr.net. [92.88.170.156])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1d978fsm56371445e9.9.2026.09.23.02.24.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 02:24:44 -0700 (PDT)
Message-ID: <c8b7beca-8857-4678-b876-d9bbee1423f6@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 11:24:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Extend comment about PV cpu load state
Content-Language: en-US
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, david@kernel.org, iii@linux.ibm.com,
 richard.henderson@linaro.org
References: <20260923082146.62803-1-frankja@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260923082146.62803-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4WwzXWhRbitkfMdsZ0nzNNbYAQErPRt4
X-Proofpoint-ORIG-GUID: 4WwzXWhRbitkfMdsZ0nzNNbYAQErPRt4
X-Authority-Analysis: v=2.4 cv=WZuZ+EhX c=1 sm=1 tr=0 ts=6ab39ade cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=eaAV3UWiRlsByXHwY8kiSA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNyBTYWx0ZWRfX7BNEzgOuu+Qy
 TqdD18Pz8xl0wFxdE880AtiEGcpooroHJnrjdEnC1LPPje5UV/Ayz7yvTQrpLDM5Jjo+SyumiKT
 6dcD3Ivj497AtIUFl43EeVy451lPAZs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNyBTYWx0ZWRfX8cU2+JedUikV
 5mwbhsQyMpgHZ3bO6Kz6uZEsQgs1Z20MzssDKPbVV96cXZDzasly6tT5rHBq81vdjnmzQK93hNk
 vwuvnkwgzIIS85nF4tURUkyAyxRb4JOnOBGEWLLy37+WOkg/l3ZQ5cZOzQT/cQIfemddf6r/ow0
 XV5jkl8xg5pYkss7tS8sN52iHGUgKLeO8Rxjbf1T/nKK33Qu8Fe4PKptQq3qlWlMypSOfgeyfDG
 1snLoMWCFWioGg13XJVt52j2BJfD1yjbwkpUWwi6fOhG66bHpFHQ2qxzouBq5f8giDxTzcLSh3q
 962n5NQO3JhagNAlqhIf0cW83q3cGBIWz/9KKA9vqPzQmQyDdi6xToZvCjZfqVDK7SrlZ1fjree
 P2u8b5Cl2DW3D1wMqtCbuVtL6ih1sOWtNLO+A37hSJbqLaKPbq4B+R8ieiUP/S1pBKFqAN0qRUB
 ElOk+MMbPj9hgAaiWsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230037
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/9/26 10:20, Janosch Frank wrote:
> When implementing PV in KVM we chose to add the cpu load state to the
> mp state solely to have a way to keep the UV happy. The UV requires us
> to set that state before running the boot cpu since entering that
> state sets the initial PSW.
> 
> Since entering that state in KVM only sets off the UV call which
> causes the initial PSW load and does not set the KVM tracking to
> operating, we need a second set mp state to reach operating state.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   target/s390x/cpu-system.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Thank you!

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

