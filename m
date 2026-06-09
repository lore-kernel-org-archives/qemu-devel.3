Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61137CD8C92
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWv8o-0001Gs-R6; Tue, 09 Jun 2026 08:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWv8n-0001GF-Jo
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:01:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWv8m-00025r-84
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:01:09 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659BnWPN2574418
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 12:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bfv8GiTsPV/rBrBZSlV+RKU3/qgEjkptTCRxzUkMAy0=; b=M3ECkCQCwkGsY9+N
 Q9YXxAKU+ehX3Zi1m19Aq5NzzrjxtEEaj0KwQE177mAj+3sn+oy0y/LAg7JsYEj4
 5bZ2A2Td05zdiDEKv/7VPL84nmsVuLY1vVDPuo+hI6ICLNNQWYCCkeDzntzpoh7d
 xJlmKr0GL4fXP57l/S5VcVEz0ol4zV+NKlagGeQxA7l1hCYRtsRUa/agTXRKyPZa
 w7i1565pBniOG7cqlqEqt19Hj/YGoAI3Oc65nyACsLDf7vmk7zlOiGdSOiwdZmmy
 TI1n/CGBJ4GiVnuTGc0scgGaG+I72bhidpu+mpbl9owqqvSAYSad8osvwPE7TDly
 bVX9oQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epfdt0txw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:01:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5177b8df670so89140401cf.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781006466; x=1781611266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bfv8GiTsPV/rBrBZSlV+RKU3/qgEjkptTCRxzUkMAy0=;
 b=Vjmj8asXNb7K2/NlrggVAn2u/t9YHmKdBp6ITl+ScvunHXgzY46AhWQbTaZA/SjV3A
 1yB2l2ow26v5PVbHzd7TKKi/vMF/Vt0G4vzj7j2OvfnwilV3cn5p+AOUu5xsy7RFvXUe
 //M8pK+DkVzuMIAGe+GDLIH0Ky1IcT0gUtIBTC83SqGPPPJUWU11myAPtwuyJshHDMTA
 lmmK91g+xy9C5bZL0jFIrBv/H4thnAAwUYgQ6HjcbVLW+xlgdVH0HJtpYVyv51AIm0k8
 Z3hn5+ZXLgf8gcDLRip1t8DdjJjKxqo3uUnDqpRl65HjZZDBL8xqCOlfcH3zrvdxHUMk
 ITyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781006466; x=1781611266;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bfv8GiTsPV/rBrBZSlV+RKU3/qgEjkptTCRxzUkMAy0=;
 b=gan2Pna2v+Q4JrvJ+Ni1VAgAHzeOCvLaouLnLeYO55tocTYhG0/oCc1MxQBEojFTNX
 tKiwH9j3WBSEpa78UsE/HGJmqNrrqxAZWzxZFDVp8E02dAiPZa5HEIwK3jNleQdSMMj1
 Wi+MjU1vsgbaK/lONr/3C6zzCjTYgJ21Of1Ihb9UvbUW9j8vwpTHdMXKekMqRpo+2HUA
 IQymIZLZAl9PUPTOyBoCvFJ+4hJ/1j5BRTzfJN24PCqFaUWP4dFsXLKqZjYvGXagz/93
 13oUWo6y/bXJGt7hNzcQbz4UxdxpAM5D9Cgp4fcit2yB3Y+F7JWO9phhT9aXfuXgJc3o
 9ZCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9EySxxZaMy6m8qwo/ja1gRiSFUJGWCdCON0eZZ651eCkmqE601FCQs2JieKk8UQDPYlVD8EBw2jFFR@nongnu.org
X-Gm-Message-State: AOJu0YzSo50JH7D9O8x8YN0bvxHNq1fyC+AXESxePMly3d9AUF2pe6CF
 KVmaDFj9fG4fgA7phYbh/UUXWE17i5qYzzTMFvZgSFGFS74I0OXUHw7zultBSWGr5uAU9EHg5Wd
 HkQ4uMTubR+MOPjVhnHmlIXPXncWHeDIK4Hi7Ojq4vyA5QH7MUaaIgTYm2Q==
X-Gm-Gg: Acq92OHIwy1aFR7jSa1vRrAlXFaDvTsJYiAJ7D4MF1UQ4+ELi2HGQQHpZFUBogrwfrF
 jGyAa2Rfi1JY29/zWgxP3+FMGZYe7eTdWRpusGuBC3agUEHSfEyB9m4cv6hG+A49UJ31lsK2MPU
 IcMylgtBoRxDWNNbWap83xLfmpJZea7TfgWYGCf38cehI5r6wriV0wfL+y7/BDH1+XZDjvMW3sP
 lQzyrb33VNKJLgo9lRnTyRkKyj+lem4Ag2VpOiWMThvL7FVjs+dVJet+y7fj27wAtuUKb7zGFiC
 5xHytIbqYrxHffFQR8viorYO6c/VzBxKW8M4kaIytAicCzCUnseyWAeUfG1YEtUXQpTyNY7YoBl
 MWmRoPQg+sKPUmXKRoWD2FZFYS1cW2HUKuqqNrhoOB2AiMqkYARmdyx7FX/DfAw==
X-Received: by 2002:a05:622a:1811:b0:50d:62d1:c3fa with SMTP id
 d75a77b69052e-517959d5f02mr294374111cf.2.1781006454686; 
 Tue, 09 Jun 2026 05:00:54 -0700 (PDT)
X-Received: by 2002:a05:622a:1811:b0:50d:62d1:c3fa with SMTP id
 d75a77b69052e-517959d5f02mr294342851cf.2.1781006434651; 
 Tue, 09 Jun 2026 05:00:34 -0700 (PDT)
Received: from [10.156.84.244] (113.170.88.92.rev.sfr.net. [92.88.170.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf051770c7csm1035248066b.12.2026.06.09.05.00.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 05:00:33 -0700 (PDT)
Message-ID: <d122c197-a1d0-43a2-bb8a-812542cb9577@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 14:00:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fpu: Handle all rounding modes in
 partsN_round_to_int_normal
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260608190155.637067-1-richard.henderson@linaro.org>
 <20260608190155.637067-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260608190155.637067-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: x8klgSbFjnPpXfd7Is9NYwlEsiqT_nXf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDExMyBTYWx0ZWRfX9CcRpUZJKRWG
 22run5Fq0YUzDoT1IqhB78X1ti995M/Q6scNTK6k8tIVnOFuDQoDsVKTnQiDb7stBpgxDJ8zHBl
 ranrq7RJXTB8CAPJDKWqJZs3/fU8hIVUq8RZYfZzb0Hm8J9MGASGRvqNfbS9JPJDdEOk/nVZa+I
 7iMxshsDFiUQU4rdbve9bAiSoCNLMrEKp7+gRhVQ8o2RBzSsy+qZtl6TOBzHF7rAxw9q19rFpVQ
 bTgE5COUT084bK5RwsTHA38fwg/QTlE64OjoR9izV7SRWWb998+KWiCV8cc3wlt0c0odLOzHfJH
 PJSxIXM8XoxgZg5o0WydzySQ7UVE3CVL5925NchRSBXrTLRLCKZmtLuu6x5DFuiIaT316qDM0TZ
 5Y8vA2meyf0ToiOf+CDN1r/uYtoBzB9YgKae9mNvQ1va82fimeFDiUF+U2iW1fm90ZBiJmkvpp8
 0ukyAu0ZVyzwVuDDMVQ==
X-Proofpoint-GUID: x8klgSbFjnPpXfd7Is9NYwlEsiqT_nXf
X-Authority-Analysis: v=2.4 cv=doTrzVg4 c=1 sm=1 tr=0 ts=6a280082 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ASywmo1ADVsXjDI2RVyDAw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090113
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 8/6/26 21:01, Richard Henderson wrote:
> Missed float_round_nearest_even_max and float_round_to_odd_inf
> in both switch statements.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

