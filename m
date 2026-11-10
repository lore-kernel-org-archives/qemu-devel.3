Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8D606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L+nUVsI8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Iiff3t7j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQadP-0007ZN-8S; Mon, 09 Nov 2026 20:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQadN-0007Z9-Bn
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 20:26:49 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQadL-0004fj-NO
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 20:26:49 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA0iuOM887633
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 01:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AnkjgK+HXczL2WlqQeBoOgK2VVfNVH1nvNF2kUhp5Z0=; b=L+nUVsI8gBg0cB9V
 tzkRwypj6feF62EK/sPoxvnT604aYxMGsr9mbSXFR7v8iWXwf7ESmEiNX1PKDPMi
 T6MTtLigCgW6rWc66fT1lrYj34Ryj1C0skbU2sm7PJbHruMt3sFtkSABrjf3emWV
 /DEt6OUrCUIOgb0bBjWGOtFVzpwhxk0QGVP+GpApvo0JAv/aNakrHI89zAu7jUTj
 MHHxDeoQo/zJqjGbyfOSJfNGWaNLkFRj2oRApuz/ornb/ZJb80hxxEbpiI3sYQV3
 s+IQR0xoM25fHg+GsU64p540x2/NEv7ZdGGkmST9jywnQOLHgBtdHDJwUpjyyJme
 Lk0NPg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudcjasv1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 01:26:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5383d650f2dso32334471cf.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 17:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794274004; x=1794878804; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AnkjgK+HXczL2WlqQeBoOgK2VVfNVH1nvNF2kUhp5Z0=;
 b=Iiff3t7jBJOu1gAwVxzSdpp37Vz9ARqhKs90vmhW0jJqTxtu+0NmroINEP64dxHsc3
 PbQr3oAYQ7L20GYcrkSou7VyVRf4FPq9TCmzE/a9myFaSfeAAPrEGVp/A+akDZzeCMUA
 VCFgPZ9TnOIzsMWrJoVbjqyfjXbb4ZB7ciVlqMVUlU7rDO6hUDR19OUSlEFUVZZA75oz
 8YypQSEk6HaKBnlQ2aLv/vRoEs7drwMsSVraTTb4FMWDTwMP7+hnaQF6xdd18UUdfNdz
 T+xPO7f18TFAbVUExtUuoPtMPAFb+QRzHBV30aAPxXsPPyV8UA9RoP+cvJLMOipFozZ9
 uIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794274004; x=1794878804;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AnkjgK+HXczL2WlqQeBoOgK2VVfNVH1nvNF2kUhp5Z0=;
 b=R8mzVxnn4TlCmgBpJmMDTCoSLVr+jXXDSL/NSSh+tx1aIKW9cc10UzkftZU5oqcSu+
 s1gT1wkqoh4MFBhbAK/KXI3B1bNm2WhgmeHAgOAkECDxVW1Co2ByaBDJKAWKd0AYwnxu
 ICNrnqKbuKGKlMGY+SahGFoRXbNaymVzLCKzLYQ9hDLutMYAh/AN1gzy8eaEWFTNfGdt
 l35lAqLXPL394EUEP311jkRBTQbjMBh9ri6ThUzfYZPet4yNQA3P5qO/V+rHusoKLCRq
 ila3jQ1rut8FdACzQBXGxCAYTXDHPgbXwgu7zjct7TNOFwdidf20njpfPxPTkq+XxzBb
 7ppg==
X-Forwarded-Encrypted: i=1;
 AL+hErEytfdMglHWscb3R958V/w37CvlEc7GV++EeEUYoAr1HHl5b/Bwt5QANkiKiGK3zCQ/eF8F2YOLzKrO@nongnu.org
X-Gm-Message-State: APuU4Z/rwwqCcjHW7jxA3s/HDBB577bOOhpMH4YI8tGqWT4NDgbnqpEk
 cgAa8tK68x4XSYYwbYFB/TEu5f8i+lXtIn6/rbOwln5MUAPh5smAp/SNDX7ENJzZuoBqmWz+jMm
 7iMpUz1a7UUiClDD6494X8gsA0gndzJqdz5qDbqSjX/a7pjlWXQToRDbE6Q==
X-Gm-Gg: AYBFou1FDLVfRD/vpkf/LgP9u0uVVSLgAG/VAyTaF2zbo6wRjKo/VXno2hSCElAYDkH
 2VAFVTeM0ycse6OnvM5w08OLYlC8iF7kz1RzWwn9T/VNXZZ/Ogw00I0T3i3c0ex2YoukK80/Geb
 B5xEy1XspEPwgkbBAdP6RMLTJoTQgcPx2mH7Fhhhe3DErEqk4ZJl4TBQL9QturH1F2m6EbNDMXU
 Xe4hUsxa5gDS0xQp7flvH5rgEeO5F44Gi02QtmBs8zPE9Vn8gVSaQpH8Fy/relRM+xAcsSYe5L7
 CeV4e3pSr7L33U2fT3hlrbHRRfiOyJl1fzaKvvUU5KkHIPJWY/qdEKMQkY6gQLgB9xcH5kjdRqS
 c3iK32Wssxfhh8OD6eCehHtiKmYPOmQy2NGsu18b1qvM+plEFm2NzXUiVqF+2LANAjh9Ts1643R
 omDyann7r663qnQv9lyjJ8+F+8x3A8fJvHvrT9oLaPiqDER6KjWXs=
X-Received: by 2002:ac8:5f8b:0:b0:536:71f5:5361 with SMTP id
 d75a77b69052e-55524cfdc49mr16999811cf.11.1794274004426; 
 Mon, 09 Nov 2026 17:26:44 -0800 (PST)
X-Received: by 2002:ac8:5f8b:0:b0:536:71f5:5361 with SMTP id
 d75a77b69052e-55524cfdc49mr16999551cf.11.1794274003937; 
 Mon, 09 Nov 2026 17:26:43 -0800 (PST)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550b44e6fcsm11241511cf.10.2026.11.09.17.26.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 17:26:41 -0800 (PST)
Message-ID: <cf55b5a5-73bd-4b30-bead-8ff6b32db3ba@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 19:26:40 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] target/hexagon: leave stack exchange to virtual
 SPSWAP
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 philmd@oss.qualcomm.com
References: <20261109232142.4081792-1-marco.liebel@oss.qualcomm.com>
 <20261109232142.4081792-4-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261109232142.4081792-4-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EA5A-3yhZq0CBy3It2nGB5treVxuK_H9
X-Proofpoint-ORIG-GUID: EA5A-3yhZq0CBy3It2nGB5treVxuK_H9
X-Authority-Analysis: v=2.4 cv=au0nmiZV c=1 sm=1 tr=0 ts=6af272d5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=1DdgN_IYk3o93nOc7f4A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAwNSBTYWx0ZWRfX2i8idecY4NhW
 4DV2FvuZYCL+E2/GOtyb3VdWlk0NNgS0SS0MIQ5HZkUjgdRBqVbIcH2wVzRyvNLnY5QjCvYt16K
 EHvMWE7lwDzYDzlvBBSR1MeOk1XnK9I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAwNSBTYWx0ZWRfX23BPKJSvE46q
 /rFf2G3rhrWgTJe1PpgfcJE/vmWcX3XewheCShiQjnScyC7UBIeFff9JRw09w5slI/De1dfDIpy
 BZxE1ur2I7SUKbyp0LIpxQGAUe/xa7HbAjXAWOjceGs79UJ7OyRS8iKbU2yFJwaCwnvmUkivAtD
 pX+YdlC7iDhNtdrm09kcUeYSiQcJG+BEePtTj8NS+NhpKCCV+3MDZXU3wE/z+4yDM/OORQVHA6m
 6JZFxw5eeoCUwV+3xKDQ0W+FlNJpa11wMa5A2pY5vfB8YI7pppoJ70rmZ5bEvylHJwEPbDJ8UTI
 6UvCBDalaDoqLsqb5JcZRzPTqp85SISC05HeegJ8kKfUKIFnRRRBtqet0FkcT8xbpaKJMuG8b9x
 HZ5TtyLTVQi53E+37LUzxxlwiUeIw68EKwqKJMpI0M4IKKmja2cdEUYLAag750ROLDy+Lr6rQyF
 ePtuO9BgzyjhdB+SnFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100005
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 11/9/2026 5:21 PM, Marco Liebel wrote:
> Virtual RTE must restore status and branch to GELR without swapping
> SP and GOSP. An implicit swap undoes the explicit exit SPSWAP and
> resumes guest user code on the kernel stack.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   target/hexagon/hexswi.c | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
> index f22d4a77516..acc68aa6c23 100644
> --- a/target/hexagon/hexswi.c
> +++ b/target/hexagon/hexswi.c
> @@ -831,12 +831,6 @@ void hexagon_vmrte(CPUHexagonState *env)
>       uint32_t old_ssr = env->t_sreg[HEX_SREG_SSR];
>       CPUState *cs = env_cpu(env);
>   
> -    if (GET_FIELD(GSR_UM, gsr)) {
> -        uint32_t sp = env->gpr[HEX_REG_SP];
> -
> -        env->gpr[HEX_REG_SP] = env->greg[HEX_GREG_GOSP];
> -        env->greg[HEX_GREG_GOSP] = sp;
> -    }
>       SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_SS,
>                        GET_FIELD(GSR_SS, gsr));
>       SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_GM,

