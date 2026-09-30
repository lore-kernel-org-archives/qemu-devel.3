Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CDCCA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoXj-0007vo-Tn; Wed, 30 Sep 2026 03:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoXc-0007vb-E3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:15:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoXZ-0000ZS-2b
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:15:46 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U6ol9q3936251
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j+JthzVfyh6HITdNKRsPfxcXMS1vgtmPB/Zp5g0K7BI=; b=c2mtNm9rLsFYIksR
 6NAWA24INBmQKnx9I9AdVGmExSClAFKzzdESG1kWJUGbiA/pWJFhRcK8UE3hwj2Y
 dofY/sY1JaXgTaCilRAphumwxd0Wo5I6y+/WTI2OoBUsN26gf5bpUD8Bs0Vc2mJd
 5ySdRr4FZ6B1cxugA3TlSpGDC+EFF7Jt68loNaE4y8OAi+8gS5S8wLyS9kipsrO6
 54VxobEdj8pMxt+Fj+gOuJ2kSO0iS34QcuKpAN7HWi5HwDKs7co1TdFrT0n+Ubrl
 ui+9TNg9ebkG6YVLT32DC0AzXpVfnRWPPtcoJOvvVi11cjoBjnFBdtcFmZBVKGo8
 LYg31g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0mfaa9aq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:15:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5333e3f5811so38971961cf.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790752542; x=1791357342; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j+JthzVfyh6HITdNKRsPfxcXMS1vgtmPB/Zp5g0K7BI=;
 b=RiJywEJWdbf+CdR9T0KFWXnQMgJxpdpGSv5Qlv5XF5HXcWDIRMosTSH/WHDUzygVqj
 Xnc7DU2MCAj7gdtkhrH4PD8DrXoYYngro+0dXWyqhzYxWzyVnLfFTRj3aDpbmnFC9eLm
 hqzvz2M/qculgB80I0DMVP8mF+I+C8TdSQ9SISKjk9/s0/XcH8Ha0GjUZP6Fk/Rmlfqb
 L757anHW0+cAj3B8+KUUkSG4vXTbDqoqPIxQev1hXIHvtQqr6ZSUEsCQPEsNnAFCjY3K
 xHhMKW+XfHxIjaK4BrLfM1ZSOfreOJHCpjtXhE2lgH2sfjkAHxeS5SE42UYPkP/Fbg7W
 zFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790752542; x=1791357342;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j+JthzVfyh6HITdNKRsPfxcXMS1vgtmPB/Zp5g0K7BI=;
 b=J5pIpfmp4RfexaDuHI31DZBmUKEtTiRLjjuo68+Wwnxf/2KG2XJLAeDRbJ3ph97qBS
 nqbGnbDAJ7w3GmtHbY0I2ik6ApC7NuKpMEgkaFsfIet/sGs2s8SV8Ly8rbVTRfVcEcg1
 X6HCNFVIRSXpyFHWbzM3qsK/ZNiMP73dWtjIPSOQtnv24wjB+nvcEZg5aIBeXc6sZZk6
 Y88+rtQVjUJucl6nHUh1Rg56yuAVcyu/+Dm3EoWHbNK5rEcLYko8aPJgSJJMreWo8GoK
 SqTWg6d8v1QwsHsulPhL6kqWIpInAhsA8L+Zt//U0HSCVNUEYxU6jaOeED6LHPKw4Jqt
 Kzbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnemQa/4xUjJoCU2DsfqBGU2UPCHaSWsLx0RhHDFiYGHxnb7fQnwc0RJJa0mu7JztXlhXoYpRCIbah@nongnu.org
X-Gm-Message-State: AFuF++mjw9U5cRu7zHvMurfTKZbKUWjVSt5DVfsjRWwEqSFegT8bLJyW
 B6uA7v+3uwI2+tYZWx/lUQx9OkPx5B9AKhOw0txjrlERsTvECLgRoNWAQh0QKVGU+H2nFnpphVU
 zx9TYAThtu6NrRvMqEj8Ei7KElKRa8roSMc1t1mhDW9Ez6JtNKpi2e6vBwQ==
X-Gm-Gg: AYBFou3mx2U88QD0lusG+BKzSbMJGUgCj/Emz2/H5K8Yyal2P2VOpKtTEAdxr+LU/Qy
 5OQxA11qaKlfyV8ylkpC7sjTGsverDYE2/wLTt+DssIzMZ0SV5JPCIqWFjib2pPCLlmssDnO1kg
 a6cVelJrZyK04aOcfZmcNYKdFtDu9tzVaGSkGwIX3lsDZzjU/wgKNlEKLpuSC3Es9mGki6drbN5
 ax0F7Izjxaue6TMeqz1uKfiJETRXkAaAixgPIZNX1CuvfWFCSBFm0KFk8Gv7owqwLh9l5d4cF/p
 eJqJxwnj5EHb5LMpj5i2J4jacWjp9okrRb0Aqz0zMlrWadS0FJLA1s25bGyk4x5rDieq2qfDmQw
 pAxVhEJRuZVxUMfiur7tUyC7FhsyaSTTZTA==
X-Received: by 2002:a05:620a:2556:b0:93a:3257:34b with SMTP id
 af79cd13be357-93ca97aa0d1mr63324385a.29.1790752542120; 
 Wed, 30 Sep 2026 00:15:42 -0700 (PDT)
X-Received: by 2002:a05:620a:2556:b0:93a:3257:34b with SMTP id
 af79cd13be357-93ca97aa0d1mr63320985a.29.1790752541572; 
 Wed, 30 Sep 2026 00:15:41 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029bf85dsm1392117f8f.13.2026.09.30.00.15.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 00:15:40 -0700 (PDT)
Message-ID: <56b81e73-45e3-48e6-8b5e-eba42878914f@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 09:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci: add multi-target job
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260929183320.2960-1-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260929183320.2960-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX56FhlNEL7fiO
 spDOoIWkyzLlDnGt4evU/kvd50yp25TnTu5WXGUZ2xoVGkyl28xdPnazlNoTv4Fi6nr68Tj0I2V
 xD+/W/V7kouhEPVJEfE96tNSGOImlQcM9Sn3uizgYEgHi/nrsG96AEQKqWqQzOKKm5SFN+hz9sy
 NBJYZq8PhRyQ7cufyijpzlpTyLXRzsdv1zzncc2n7E2M5pKXD6LHV8RFHAySTY4S+c9YPADeCIv
 FBQvn5hB93kdjz9lpkb4xW8JpQU8Flwb2Vhdex27cFWlJbOUmJejJoCpWVv0SaDZBLd+9q90+qB
 6pwE2r55FDuDemLV57JZtxFPhSSxukQO4ZEw5GIHQpNDNIuSH9M7ZJ7ingc3IjWWlB9wCnhNBPr
 OLEhW7JrTsXNt0clsXTiwrIW3YE1bQ6a4Gef8OKYmoRu0vmkIHlaOmlFF2NDqDnMieGNfdWmCVy
 PhfjzV7Tnpz8o+UaJCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfXzxunkFxGWanX
 iT3YK9ZI73u9YJSQjn6DT51w54pSXAGK09ZRVbIG6uDoGR6Bmgnv+9QtYDaLxIbfetMBEL5HkuC
 Lh45CbEZbNs07B0XuANc+qmrn5iwy/0=
X-Authority-Analysis: v=2.4 cv=RZEFmFtv c=1 sm=1 tr=0 ts=6abcb71f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: pSpiSLjmLpVziq1GPwz1C4-9IYDbqd3K
X-Proofpoint-ORIG-GUID: pSpiSLjmLpVziq1GPwz1C4-9IYDbqd3K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300028
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

On 29/9/26 20:33, Pierrick Bouvier wrote:
> This check ensures we don't bring regression for all targets that can be
> linked together by building multi-target test. Also, running it ensure
> all QOM types are unique.
> 
> All compatible targets are automatically detected, so they don't need to
> be fed to ./configure.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

